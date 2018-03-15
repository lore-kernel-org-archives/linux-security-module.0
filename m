From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:49:01 +0200
Subject: [PATCH v2 8/8] tpm: move tpm2 code validation to tpm2-space.c
In-Reply-To: <20180310082428.31519-9-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-9-tomas.winkler@intel.com>
Message-ID: <1122028a7efd57fa6b5c1cabfd470fe986f7acba.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Add new function tpm2_validate_command to tpm2-space.c
> that wraps up open coded functionality from tpm_validate_command.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Same comment as for 7/8. Probably might apply also for 1-6.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
