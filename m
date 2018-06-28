From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 28 Jun 2018 16:30:49 +0300
Subject: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
	<19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
	<cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
	<5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
Message-ID: <722fe86b2651d2616fa9bf43d9f8b1322f4c868b.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-06-27 at 21:13 +0000, Winkler, Tomas wrote:
> Very well, I will remove the NESTED flag.  though I have feeling you are
> shooting from the hip you didn't really read the code. 
> Please there anyone who can review the code?

Asking to change a minor thing in a patch does not really fit into that
profile. I've even tried the patch a few times in it seems to work just
fine. You are making a big deal out of nothing.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
