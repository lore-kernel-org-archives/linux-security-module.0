From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 27 Jun 2018 19:42:24 +0300
Subject: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
	<19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
	<cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
Message-ID: <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 21:15 +0000, Winkler, Tomas wrote:
> > Right now if I really put head into this I can understand the logic but it
> > is a
> > complete mess.
> 
> I think what is the mess is that we have a recursive call to tpm_transmit
> topped with retries.  All other mess is just the result of that.
> 
> > I will forgot the dependencies between flags within few
> > weeks. 
> 
> Hope the reasons are well documented both in code and the commit message, if
> not let's address that. We really cannot depend on one's memory.
> It's not like I'm not striving for simplest possible code. 
> 
> > A fixed requirement (so that you know) is that they must be
> > independent.
> 
> The flags (hope this what you referring here to) are not independent and
> weren't before, (RAW cannot be called alone as you will have double locking)
> putting them under one name just should make it clear. 
> I beg you to go over the  code one more time, don't get stuck with flags
> names, maybe you even discover some real issue. 
> 
> Thanks
> Tomas

You should then find a solution where you can remove TPM_TRANSMIT_RAW
completely and make it as a separate commit, not part of the bug fix.
This is not in a shape that I would dare to put this in a pull request.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
