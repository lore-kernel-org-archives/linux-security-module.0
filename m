From: konstantin@linuxfoundation.org (Konstantin Ryabitsev)
Date: Mon, 13 Mar 2017 12:05:22 -0400
Subject: Kernel repository updated to v4.11-rc1  *** reverted ??? ***
In-Reply-To: <1489419650.28954.173.camel@linux.vnet.ibm.com>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
	<1489406649.28954.143.camel@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1703140123580.23070@namei.org>
	<20170313145318.GA20608@gmail.com>
	<1489417657.28954.163.camel@linux.vnet.ibm.com>
	<20170313153332.GB20608@gmail.com>
	<1489419650.28954.173.camel@linux.vnet.ibm.com>
Message-ID: <20170313160522.GE20608@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 13, 2017 at 11:40:50AM -0400, Mimi Zohar wrote:
>$ host git.kernel.org
>git.kernel.org is an alias for pub.kernel.org.
>pub.kernel.org is an alias for pub.ewr.kernel.org.
>pub.ewr.kernel.org has address 147.75.196.57
>pub.ewr.kernel.org has IPv6 address 2604:1380:1:3600::3

The EWR frontend was the culprit. There were hardware problems with the 
first EWR system we brought up, so I had to resync the replacement 
system from it. The origin for some of the repositories was still 
pointing at the dead box, so the updates did not properly propagate to 
EWR.

It should be in a happier place now.

-Konstantin
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
