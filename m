From: jmorris@namei.org (James Morris)
Date: Thu, 17 Aug 2017 12:39:00 +1000 (AEST)
Subject: [Linux-ima-devel] [RFC PATCH 2/4] ima: define new
	ima_sb_post_new_mount hook
In-Reply-To: <1502917153.21278.48.camel@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
	<63522b3b-5e61-f760-5f74-f9fbe44741f5@schaufler-ca.com>
	<1502917153.21278.48.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.20.1708171233440.10905@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 16 Aug 2017, Mimi Zohar wrote:

> In this context, I'm not sure what you mean by "loaded".? IMA needs to
> be enabled from the very beginning to capture all measurements and
> verify the integrity of files, without any gaps. ?At some point this
> would include other LSM policies.

I think it's better to keep IMA orthogonal to LSM for this reason.

The original motivation to implement IMA as a separate API was because LSM 
was at the time considered specific to access control mechanisms, although 
that is not the case now.

-- 
James Morris
<jmorris@namei.org>
