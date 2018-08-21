From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 21 Aug 2018 12:31:08 -0600
Subject: [PATCH 04/23] TPM: Expose struct tpm_chip and related find_get
	and put functions
In-Reply-To: <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
	<153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
Message-ID: <20180821183108.GC25543@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:16PM +0100, David Howells wrote:
> Expose struct tpm_chip and related find_get and put functions so that
> TPM-using code can make sure it uses the same TPM for any related set of
> operations.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---

>  drivers/char/tpm/tpm-interface.c |   19 ++++++++++++++++---
>  drivers/char/tpm/tpm.h           |    5 -----
>  include/linux/tpm.h              |   10 ++++++++++
>  3 files changed, 26 insertions(+), 8 deletions(-)

I think this is already in the kernel .. Stephen did it.

Jason
