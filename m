From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 26 Feb 2018 21:26:58 +0200
Subject: [PATCH 2/7] genalloc: selftest
In-Reply-To: <20180226191235.GA24087@bombadil.infradead.org>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
	<20180223144807.1180-3-igor.stoppa@huawei.com>
	<76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
	<a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
	<45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
	<20249e10-4a13-8084-bcf2-0f98497a755f@huawei.com>
	<20180226191235.GA24087@bombadil.infradead.org>
Message-ID: <aa491cf5-ace4-1e2c-2f49-60f96b1e6da9@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 26/02/18 21:12, Matthew Wilcox wrote:
[...]

> panic() halts the kernel
> BUG_ON() kills the thread
> WARN_ON() just prints messages
> 
> Now, if we're at boot time and we're still executing code from the init
> thread, killing init is equivalent to halting the kernel.
> 
> The question is, what is appropriate for test modules?  I would say
> WARN_ON is not appropriate because people ignore warnings.  BUG_ON is
> reasonable for development.  panic() is probably not.

Ok, so I can leave WARN_ON() in the libraries, and keep the more
restrictive BUG_ON() for the self test, which is optional for both
genalloc and pmalloc.

> Also, calling BUG_ON while holding a lock is not a good idea; if anything
> needs to acquire that lock to shut down in a reasonable fashion, it's
> going to hang.
> 
> And there's no need to do something like BUG_ON(!foo); foo->wibble = 1;
> Dereferencing a NULL pointer already produces a nice informative splat.
> In general, we assume other parts of the kernel are sane and if they pass
> us a NULL pool, it's no good returning -EINVAL, we may as well just oops
> and let somebody else debug it.

Great, that makes the code even simpler.

--
igor

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
