From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 25 Jun 2018 19:57:29 +0300
Subject: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
	<20180618180406.GA20697@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
	<20180621161958.GA11859@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
Message-ID: <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-06-21 at 18:40 +0000, Winkler, Tomas wrote:
> I just wanted to make sure that 'RAW' not used in the api directly, it will
> break the flow, do have any suggestion to make it obvious.

We will look at each code review as for any other peace of code how this
flag is used and make decisions at that point what is legit use and what
is not.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
