From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Mon, 11 Jun 2018 21:46:35 -0700
Subject: [PATCH v2 2/2] tpm: add support for nonblocking operation
In-Reply-To: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
	<201806120803.W0vjfLEH%fengguang.wu@intel.com>
Message-ID: <359fe9af-ba17-e23b-a21e-c3c94f23b5ff@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/11/2018 07:53 PM, kbuild test robot wrote:
> Hi Tadeusz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on next-20180608]
> [cannot apply to v4.17]

Hi,
Thanks for the report. This patch should go on top of
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/?h=next-tpm
I will check the config tomorrow.
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
