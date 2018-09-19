From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:24:34 +0300
Subject: [PATCH v3 20/20] tpm1: reimplement tpm1_continue_selftest()
	using tpm_buf
In-Reply-To: <20180918093459.19165-21-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-21-tomas.winkler@intel.com>
Message-ID: <20180919152434.GM31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:59PM +0300, Tomas Winkler wrote:
> Reimplement tpm1_continue_selftest() using tpm_buf structure.
> This is the last command using the old tpm_cmd_t structure
> and now the structure can be removed.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Minor rant: the last sentence should state simply that as there
are no other fields in tpm_cmd_t can be removed. The rationale
is that the patch set ceases to exist after it is accepted. It
is a temporary item, not something that should be referred in
the commit log.

/Jarkko
