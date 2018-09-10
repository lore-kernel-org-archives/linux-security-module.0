From: jarkko.sakkinen@intel.com (Sakkinen, Jarkko)
Date: Mon, 10 Sep 2018 18:24:20 +0000
Subject: [RFC 10/12] x86/pconfig: Program memory encryption keys on a
	system-wide basis
In-Reply-To: <0947e4ad711e8b7c1f581a446e808f514620b49b.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<0947e4ad711e8b7c1f581a446e808f514620b49b.1536356108.git.alison.schofield@intel.com>
Message-ID: <73c60d4f8a953476f1e29aaccbeb7f732c209190.camel@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-07 at 15:38 -0700, Alison Schofield wrote:
> The kernel manages the MKTME (Multi-Key Total Memory Encryption) Keys
> as a system wide single pool of keys. The hardware, however, manages
> the keys on a per physical package basis. Each physical package
> maintains a key table that all CPU's in that package share.
> 
> In order to maintain the consistent, system wide view that the kernel
> requires, program all physical packages during a key program request.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Just kind of checking that are you talking about multiple cores in
a single package or really multiple packages?

/Jarkko
