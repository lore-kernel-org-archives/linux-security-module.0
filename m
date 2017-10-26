From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 26 Oct 2017 14:22:22 -0400
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <29447.1509035858@warthog.procyon.org.uk>
References: <29447.1509035858@warthog.procyon.org.uk>
Message-ID: <1509042142.5886.61.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-10-26 at 17:37 +0100, David Howells wrote:
> Hi James,
> 
> Can you pull this patchset into security/next please?
> 
> It adds kernel lockdown support for EFI secure boot.  Note that it doesn't yet
> cover:
> 
> 	bpf	- No agreement as to how
> 	ftrace	- Recently suggested, query sent to maintainer
> 	perf	- Not looked at yet.
> 
> and there are some changes recently proposed that make it work with IMA that
> I'll pass on as a follow up when we've fully worked them out.

There's a major difference between leaving out support and preventing
properly signed code from working properly. ?We're already at -rc6.
I'm just not sure how there will be time to include the patches, test,
and send James a subsequent pull request before the next open window?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
