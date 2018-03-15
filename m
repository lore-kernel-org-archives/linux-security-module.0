From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:35:36 +0200
Subject: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Message-ID: <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c
> similarly to tpm2-cmd.c, as well as move TPM2 open code flows
> into new functions to tpm2-cmd.c
> The functions in tpm-interface.c should now be in form:

In which patch tpm1-cmd.c is created?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
