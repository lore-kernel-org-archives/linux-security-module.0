From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 14 Aug 2018 19:06:05 +0300
Subject: [PATCH v5 1/2] tpm: add ptr to the tpm_space struct to file_priv
In-Reply-To: <153419237378.8189.17192381683473461307.stgit@tstruk-mobl1.jf.intel.com>
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
	<153419237378.8189.17192381683473461307.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180814160605.GC13648@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 13, 2018 at 01:32:53PM -0700, Tadeusz Struk wrote:
> Add a ptr to struct tpm_space to the file_priv to have an easy
> access to it in the async job without the need to allocate memory.
> This also allows to consolidate of the write operations for
> the two interfaces.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

NAK

A rule thumb: do not add "links" between commits unless it is you cannot
find any other way. The cover letter is made for describing feature or
features that are defined a the set of commits.

What is "async job" anyway? It is a bogus term.

Please refer to only merged code in your commit message, not futures.

/Jarkko
