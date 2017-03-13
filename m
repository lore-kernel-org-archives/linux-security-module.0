From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 13 Mar 2017 11:40:50 -0400
Subject: Kernel repository updated to v4.11-rc1  *** reverted ??? ***
In-Reply-To: <20170313153332.GB20608@gmail.com>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
	<1489406649.28954.143.camel@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1703140123580.23070@namei.org>
	<20170313145318.GA20608@gmail.com>
	<1489417657.28954.163.camel@linux.vnet.ibm.com>
	<20170313153332.GB20608@gmail.com>
Message-ID: <1489419650.28954.173.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-03-13 at 11:33 -0400, Konstantin Ryabitsev wrote:
> On Mon, Mar 13, 2017 at 11:07:37AM -0400, Mimi Zohar wrote:
> >For me, both the git repo and the URL are wrong:
> >
> >git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
> >https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> 
> Can you give me the output of 'host git.kernel.org'? It's geo-based now, 
> so can be pointing to one of 4 different frontends.

$ host git.kernel.org
git.kernel.org is an alias for pub.kernel.org.
pub.kernel.org is an alias for pub.ewr.kernel.org.
pub.ewr.kernel.org has address 147.75.196.57
pub.ewr.kernel.org has IPv6 address 2604:1380:1:3600::3

$ git branch -rv | grep "security/next"
  security/next                                            61841be6358c tpm: declare tpm2_get_pcr_allocation() as static

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
