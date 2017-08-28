From: jmorris@namei.org (James Morris)
Date: Mon, 28 Aug 2017 14:09:36 +1000 (AEST)
Subject: [PATCH net-next v7 04/10] bpf: Define handle_fs and add a new
	helper bpf_handle_fs_get_mode()
In-Reply-To: <20170821000933.13024-5-mic@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-5-mic@digikod.net>
Message-ID: <alpine.LRH.2.20.1708281408430.8842@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 21 Aug 2017, Micka?l Sala?n wrote:

> @@ -85,6 +90,8 @@ enum bpf_arg_type {
>  
>  	ARG_PTR_TO_CTX,		/* pointer to context */
>  	ARG_ANYTHING,		/* any (initialized) argument is ok */
> +
> +	ARG_CONST_PTR_TO_HANDLE_FS,	/* pointer to an abstract FS struct */
>  };

Looks like a spurious empty line.

-- 
James Morris
<jmorris@namei.org>
