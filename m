From: keescook@chromium.org (Kees Cook)
Date: Wed, 22 Mar 2017 11:12:59 -0700
Subject: [PATCH 1/2] LSM: Initialize security_hook_heads upon registration.
In-Reply-To: <1490179580-7065-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1490179580-7065-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <CAGXu5jJwnYxzd=mVQiSJz8VEfnef34SavxGPHaX0_dOU3fyUDA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 22, 2017 at 3:46 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> "struct security_hook_heads" is an array of "struct list_head"
> where elements can be initialized just before registration.
>
> We might introduce different "struct security_hook_heads" for built-in
> LSM modules and dynamically loadable LSM modules when we start allowing
> dynamically loadable LSM modules. But even if we decide to use different
> lists, there is no need to waste 350+ lines for initialization. Let's
> initialize "struct security_hook_heads" just before registration.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <james.l.morris@oracle.com>

This seems nice to me! struct security_hook_heads is really just a
named array. :) If we wanted to do this without cast, we could convert
the named list_heads to an enum, but that should likely be a separate
change.

Acked-by: Kees Cook <keescook@chromium.org>


-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
