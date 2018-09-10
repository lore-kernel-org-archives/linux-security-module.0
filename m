From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 10 Sep 2018 13:12:31 +0300
Subject: [RFC 02/12] mm: Generalize the mprotect implementation to
	support extensions
In-Reply-To: <2dcbb08ed8804e02538a73ee05a4283c54180e36.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<2dcbb08ed8804e02538a73ee05a4283c54180e36.1536356108.git.alison.schofield@intel.com>
Message-ID: <0663b867003511f1ca652cef6acce589a5184a4b.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-07 at 15:34 -0700, Alison Schofield wrote:
> Today mprotect is implemented to support legacy mprotect behavior
> plus an extension for memory protection keys. Make it more generic
> so that it can support additional extensions in the future.
> 
> This is done is preparation for adding a new system call for memory
> encyption keys. The intent is that the new encrypted mprotect will be
> another extension to legacy mprotect.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  mm/mprotect.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 68dc476310c0..56e64ef7931e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -35,6 +35,8 @@
>  
>  #include "internal.h"
>  
> +#define NO_PKEY  -1

This commit does not make anything more generic but it does take
away a magic number. The code change is senseful. The commit
message is nonsense.

PS. Please use @linux.intel.com for LKML.

/Jarkko
