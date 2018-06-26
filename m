From: jmorris@namei.org (James Morris)
Date: Wed, 27 Jun 2018 02:39:42 +1000 (AEST)
Subject: [PATCH 0/3] KEYS: Miscellaneous fixes
In-Reply-To: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
References: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1806270239220.18107@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 26 Jun 2018, David Howells wrote:

> 
> Hi James,
> 
> Here's a bunch of miscellaneous fixes:
> 
>  (1) Fix the handling of the X.509 signature BIT STRING.
> 
>  (2) Fix a section declaration.
> 
>  (3) Fix rounding in KDF.
> 
> Could you pass these on to Linus please?

Sure, the RSA one is already merged.

> 
> The patches can be found here tagged thusly:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	keys-fixes-20180626
> 
> and also on the following branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes
> 
> David
> ---
> Eric Biggers (1):
>       dh key: fix rounding up KDF output length
> 
> Maciej S. Szmigiero (1):
>       X.509: unpack RSA signatureValue field from BIT STRING
> 
> Nick Desaulniers (1):
>       certs/blacklist: fix const confusion
> 
> 
>  certs/blacklist.h                         |    2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |    9 +++++++++
>  security/keys/dh.c                        |    6 ++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
