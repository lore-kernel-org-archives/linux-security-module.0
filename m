From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 10:44:36 -0700
Subject: [PATCH v3 15/16] LSM: Infrastructure management of the ipc
	security blob
In-Reply-To: <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
Message-ID: <CAGXu5jJRQzWF=C_kmOpZ8XcUzAhkoZnNi7a7KzEHJtFhMNd+3Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> LSM: Infrastructure management of the ipc security blob
>
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.

Maybe split this up too? (SELinux and Smack need tweaks?)

-Kees

-- 
Kees Cook
Pixel Security
