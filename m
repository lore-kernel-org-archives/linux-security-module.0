From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:58:15 -0700
Subject: [PATCH v4 18/19] LSM: Infrastructure management of the ipc
	security blob
In-Reply-To: <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
Message-ID: <CAGXu5jLqvrvTe+RmNs86H0ud+9AW8wT8yEbbWeYxmisuOKZQxw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
