From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Sep 2018 16:54:37 -0700
Subject: [PATCH 05/10] SELinux: Abstract use of file security blob
In-Reply-To: <65bccad6-5669-9f4a-a645-35e0da301817@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<65bccad6-5669-9f4a-a645-35e0da301817@schaufler-ca.com>
Message-ID: <CAGXu5jKVXdz+9qp+UCxRiVoXJrMbPxQcNDYy21e3E37pVF5ymg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seems delightfully mechanical.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
