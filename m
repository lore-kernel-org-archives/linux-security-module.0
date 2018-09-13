From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Sep 2018 17:23:39 -0700
Subject: [PATCH 07/10] SELinux: Abstract use of inode security blob
In-Reply-To: <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
Message-ID: <CAGXu5jLvyCXgtE6-S05kEQqBnZwftRanRTVYJOnBRPJJnOK4Vw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Happily mechanical! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
