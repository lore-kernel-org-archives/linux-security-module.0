From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:56:20 -0700
Subject: [PATCH v4 15/19] LSM: Infrastructure management of the task
	security
In-Reply-To: <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
Message-ID: <CAGXu5jLdBRp2vBNxZby6=J4CRU=8jJsUxjGBXj-DLCfZ+Oao6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the task_struct->security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> The only user of this blob is AppArmor. The AppArmor use
> is abstracted to avoid future conflict.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
