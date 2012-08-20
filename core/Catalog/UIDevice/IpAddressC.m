//
//  IpAddress.m
//  HttpTest
//
//  Created by shrek on 10-9-8.
//  Copyright 2010 e0571.com. All rights reserved.
//

//#import "IpAddress.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>

#include "IpAddressC.h"

#define	min(a,b)	((a) < (b) ? (a) : (b))
#define	max(a,b)	((a) > (b) ? (a) : (b))

#define BUFFERSIZE	4000

char *if_namesC[MAXADDRS];
char *ip_namesC[MAXADDRS];
char *hw_addrsC[MAXADDRS];
unsigned long ip_addrsC[MAXADDRS];

static int   nextAddr = 0;

//@implementation IpAddress

void InitAddressesC(void)
{
	int i;
	for (i=0; i<MAXADDRS; ++i)
	{
		if_namesC[i] = ip_namesC[i] = hw_addrsC[i] = NULL;
		ip_addrsC[i] = 0;
	}
}

void FreeAddressesC(void)
{
	int i;
	for (i=0; i<MAXADDRS; ++i)
	{
		if (if_namesC[i] != 0) free(if_namesC[i]);
		if (ip_namesC[i] != 0) free(ip_namesC[i]);
		if (hw_addrsC[i] != 0) free(hw_addrsC[i]);
		ip_addrsC[i] = 0;
	}
	InitAddressesC();
}

void GetIPAddressesC(void) 
{
	int                 i, len, flags;
	char                buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
	struct ifconf       ifc;
	struct ifreq        *ifr, ifrcopy;
	struct sockaddr_in	*sin;
	
	char temp[80];
	
	int sockfd;
	
	for (i=0; i<MAXADDRS; ++i)
	{
		if_namesC[i] = ip_namesC[i] = NULL;
		ip_addrsC[i] = 0;
	}
	
	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0)
	{
		perror("socket failed");
		return;
	}
	
	ifc.ifc_len = BUFFERSIZE;
	ifc.ifc_buf = buffer;
	
	if (ioctl(sockfd, SIOCGIFCONF, &ifc) < 0)
	{
		perror("ioctl error");
		return;
	}
	
	lastname[0] = 0;
	
	for (ptr = buffer; ptr < buffer + ifc.ifc_len; )
	{
		ifr = (struct ifreq *)ptr;
		len = max(sizeof(struct sockaddr), ifr->ifr_addr.sa_len);
		ptr += sizeof(ifr->ifr_name) + len;	// for next one in buffer
		
		if (ifr->ifr_addr.sa_family != AF_INET)
		{
			continue;	// ignore if not desired address family
		}
		
		if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL)
		{
			*cptr = 0;		// replace colon will null
		}
		
		if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0)
		{
			continue;	/* already processed this interface */
		}
		
		memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
		
		ifrcopy = *ifr;
		ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
		flags = ifrcopy.ifr_flags;
		if ((flags & IFF_UP) == 0)
		{
			continue;	// ignore if interface not up
		}
		
		if_namesC[nextAddr] = (char *)malloc(strlen(ifr->ifr_name)+1);
		if (if_namesC[nextAddr] == NULL)
		{
			return;
		}
		strcpy(if_namesC[nextAddr], ifr->ifr_name);
		
		sin = (struct sockaddr_in *)&ifr->ifr_addr;
		strcpy(temp, inet_ntoa(sin->sin_addr));
		
		ip_namesC[nextAddr] = (char *)malloc(strlen(temp)+1);
		if (ip_namesC[nextAddr] == NULL)
		{
			return;
		}
		strcpy(ip_namesC[nextAddr], temp);
		
		ip_addrsC[nextAddr] = sin->sin_addr.s_addr;
		
		++nextAddr;
	}
	
	close(sockfd);
}

void GetHWAddressesC(void)
{
	struct ifconf ifc;
	struct ifreq *ifr;
	int i, sockfd;
	char buffer[BUFFERSIZE], *cp, *cplim;
	char temp[80];
	
	for (i=0; i<MAXADDRS; ++i)
	{
		hw_addrsC[i] = NULL;
	}
	
	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0)
	{
		perror("socket failed");
		return;
	}
	
	ifc.ifc_len = BUFFERSIZE;
	ifc.ifc_buf = buffer;
	
	if (ioctl(sockfd, SIOCGIFCONF, (char *)&ifc) < 0)
	{
		perror("ioctl error");
		close(sockfd);
		return;
	}
	
	ifr = ifc.ifc_req;
	
	cplim = buffer + ifc.ifc_len;
	
	for (cp=buffer; cp < cplim; )
	{
		ifr = (struct ifreq *)cp;
		if (ifr->ifr_addr.sa_family == AF_LINK)
		{
				//struct sockaddr_dl *sdl = (struct sockaddr_dl *)&ifr->ifr_addr;
			int a,b,c,d,e,f;
			int i;
			
				//strcpy(temp, (char *)ether_ntoa(LLADDR(sdl)));
			sscanf(temp, "%x:%x:%x:%x:%x:%x", &a, &b, &c, &d, &e, &f);
			sprintf(temp, "%02X:%02X:%02X:%02X:%02X:%02X",a,b,c,d,e,f);
			
			for (i=0; i<MAXADDRS; ++i)
			{
				if ((if_namesC[i] != NULL) && (strcmp(ifr->ifr_name, if_namesC[i]) == 0))
				{
					if (hw_addrsC[i] == NULL)
					{
						hw_addrsC[i] = (char *)malloc(strlen(temp)+1);
						strcpy(hw_addrsC[i], temp);
						break;
					}
				}
			}
		}
		cp += sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
	}
	
	close(sockfd);
}

//@end
