From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 20:02:57 -0700
Subject: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Message-ID: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> v4: Finer granularity in the patches and other
>     cleanups suggested by Kees Cook.
>     Removed dead code created by the removal of SELinux
>     credential blob poisoning.

Thanks for the splitting, this really does make it easier to review
(at least for me). I think this looks really good, though obviously
I'd like to refactor it slightly on top of my series. :)

One additional thought I had was about the blobs allocations: some are
separate kmem caches, and some are kmalloc. I'm thinking it might make
sense to use separate kmem caches for two reasons:

- they're going to always be the same size and are regularly
allocated/freed, so it may offer a performance benefit.

- they're explicitly not supposed to be exposed to userspace, so
hardened usercopy would protect them if they were not kmalloc()ed.

I'm excited about getting this landed!

-Kees

-- 
Kees Cook
Pixel Security
