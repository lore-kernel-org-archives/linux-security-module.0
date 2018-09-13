From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Sep 2018 17:24:31 -0700
Subject: [PATCH 08/10] Smack: Abstract use of inode security blob
In-Reply-To: <70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
Message-ID: <CAGXu5jLnRbEy8h5QVVF=D-qu1Yt=vv5do5+_YVHe2asP84ShJA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
