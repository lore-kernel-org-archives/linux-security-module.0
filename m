From: keescook@chromium.org (Kees Cook)
Date: Mon, 14 Aug 2017 14:10:54 -0700
Subject: [PATCH v4 0/4] seccomp: Implement SECCOMP_RET_KILL_PROCESS action
In-Reply-To: <CAHC9VhTeotOHSD+qKG=TF-SidFT0-46GnE_pz=rjGt6gzr1mcw@mail.gmail.com>
References: <1502489117-70522-1-git-send-email-keescook@chromium.org>
	<CAHC9VhTeotOHSD+qKG=TF-SidFT0-46GnE_pz=rjGt6gzr1mcw@mail.gmail.com>
Message-ID: <CAGXu5jKbpJ8YUZX5G_4eyk5WoScv9sSnU8xMes=pXf2C3u7PfA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 14, 2017 at 1:46 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Aug 11, 2017 at 6:05 PM, Kees Cook <keescook@chromium.org> wrote:
>> This series is the result of Fabricio, Tyler, Will and I going around a
>> few times on possible solutions for finding a way to enhance RET_KILL
>> to kill the process group. There's a lot of ways this could be done,
>> but I wanted something that felt cleanest. My sense of what constitutes
>> "clean" has shifted a few times, and after continually running into
>> weird corner cases, I decided to make changes to the seccomp action mask,
>> which shouldn't be too invasive to userspace as it turns out. Everything
>> else becomes much easier, especially after being able to use Tyler's
>> new SECCOMP_GET_ACTION_AVAIL operation.
>>
>> This renames SECCOMP_RET_KILL to SECCOMP_RET_KILL_THREAD and adds
>> SECCOMP_RET_KILL_PROCESS.
>
> I just took a very quick look and I'm not seeing anything that would
> cause any backwards compatibility issues for libseccomp.  You could
> try running the libseccomp tests against a patched kernel to make
> sure; the README has all the info you need (pay special attention to
> the "live" tests, although those are pretty meager at the moment).

Ah-ha, perfect. Ran it now and yup, these all pass. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
