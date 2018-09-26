From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 26 Sep 2018 08:59:38 -0400
Subject: Leaking path for search_binary_handler
In-Reply-To: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
References: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
Message-ID: <e36e7259-5cf8-3c5b-98d3-5c4d5c4b82b1@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/25/2018 01:27 PM, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> search_binary_handler() should be called after setting bprm using prepare_binprm(),
> and in prepare_binprm(), there?s a LSM hook security_bprm_set_creds(),
> which can make a decision that binfmt cares.
> 
> We found a leaking path In fs/binfmt_misc.c:235, that don?t ask LSM?s decision.

Do you mean the MISC_FMT_CREDENTIALS case? That looks intentional to me, 
as noted in the comment there, and as per 
Documentation/admin-guide/binfmt-misc.rst's discussion of the 
credentials flag.
