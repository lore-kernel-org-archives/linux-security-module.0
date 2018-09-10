From: jarkko.sakkinen@intel.com (Sakkinen, Jarkko)
Date: Mon, 10 Sep 2018 17:57:00 +0000
Subject: [RFC 05/12] x86/mm: Add a helper function to set keyid bits in
	encrypted VMA's
In-Reply-To: <efec45aae8dab3f4db8a79d001ec65137748cdb1.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<efec45aae8dab3f4db8a79d001ec65137748cdb1.1536356108.git.alison.schofield@intel.com>
Message-ID: <7d89c2ca26aee64d1e8d36332c770746a9462d13.camel@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-07 at 15:36 -0700, Alison Schofield wrote:
> Store the memory encryption keyid in the upper bits of vm_page_prot
> that match position of keyid, bits 51:46, in a PTE.

Would not do bad to explain the context a bit here. At least I do not
know why you ended up to this bit range.

/Jarkko
