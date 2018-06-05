From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 05 Jun 2018 17:35:13 -0400
Subject: [PATCH v4a 8/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
	<CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
	<1527635645.3534.39.camel@linux.vnet.ibm.com>
	<CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
	<1527780226.3427.20.camel@linux.vnet.ibm.com>
	<CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
Message-ID: <1528234513.3557.16.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:

> And if you must have a separate enum, please change this to fail
> closed instead of open (and mark the fall-through):
> 
> int rc = -EPERM;
> 
> switch (id) {
> case LOADING_MODULE:
>     rc = loadpin_read_file(NULL, READING_MODULE);
>     /* Fall-through */
> default:
>     break;
> }

This will fail the sysfs firmware fallback loading and the kexec_load
syscall without any message, as you have for init_module. ?Is that
what you want?

Mimi

?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
