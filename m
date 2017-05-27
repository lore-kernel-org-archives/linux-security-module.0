From: keescook@chromium.org (Kees Cook)
Date: Sat, 27 May 2017 13:09:59 -0700
Subject: [PATCH v2 05/20] randstruct: Whitelist struct security_hook_heads
	cast
In-Reply-To: <20170527084135.GA26844@infradead.org>
References: <1495829844-69341-1-git-send-email-keescook@chromium.org>
	<1495829844-69341-6-git-send-email-keescook@chromium.org>
	<20170527084135.GA26844@infradead.org>
Message-ID: <CAGXu5j+SA8N6s7StQX1OQsNf6YeQBkS7vSFVN7MR=BzJMwJH9Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 27, 2017 at 1:41 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 26, 2017 at 01:17:09PM -0700, Kees Cook wrote:
>> The LSM initialization routines walk security_hook_heads as an array
>> of struct list_head instead of via names to avoid a ton of needless
>> source. Whitelist this to avoid the false positive warning from the
>> plugin:
>
> I think this crap just needs to be fixed properly.  If not it almost
> defeats the protections as the "security" ops are just about everywhere.

There's nothing unsafe about 3dfc9b02864b19f4dab376f14479ee4ad1de6c9e,
it just avoids tons of needless code. Tetsuo has some other ideas for
cleaning it up further, but I don't like it because it removes
compile-time verification of function types. There have been a lot of
trade-offs in getting this working correctly, so I don't have any
problem with how it looks currently. It's just a collision of
assumptions between randstruct (omg, you're accessing a randomized
struct with a different struct!) and the security head list (all
entries are lists, and we're just initializing them).

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
