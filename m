From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 10 Mar 2018 18:01:52 +0200
Subject: [PATCH V2] tpm_crb: use __le64 annotated variable for response
	buffer address
In-Reply-To: <20180306093415.12356-1-tomas.winkler@intel.com>
References: <20180306093415.12356-1-tomas.winkler@intel.com>
Message-ID: <c440c1eeedc9640d8355606f4935048279bf5b1e.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 11:34 +0200, Tomas Winkler wrote:
> use __le64 annotated variable for response buffer address as this is
> read in little endian format form the register.
> 
> This suppresses sparse warning
> drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
