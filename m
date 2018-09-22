From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:53:24 -0700
Subject: [PATCH v4 11/19] LSM: Infrastructure management of the file
	security
In-Reply-To: <1ca14e0b-6a95-4efe-7a23-e82d7562df26@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<1ca14e0b-6a95-4efe-7a23-e82d7562df26@schaufler-ca.com>
Message-ID: <CAGXu5jK-9O=ttcaLF6QNenhLXS9FeXPDardSKAu2-4fwaNJDGw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the file->f_security blob out of the
> individual security modules and into the infrastructure.
> The modules no longer allocate or free the data, instead
> they tell the infrastructure how much space they require.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
