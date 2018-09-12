From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Sep 2018 16:10:25 -0700
Subject: [PATCH 03/10] SELinux: Abstract use of cred security blob
In-Reply-To: <39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
Message-ID: <CAGXu5jLBwipu9WD41rQvdTjoM=+3gigrA3sp1s1gFv8C_U0nRg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Like smack, this seems to be largely:

s/$identifier->security/selinux_cred($identifier)/
s/current_security()/selinux_cred(current_cred())/

Is that right? The one __task_cred() use seemed to be fully contained
under rcu read lock.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
