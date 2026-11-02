Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632170;
	b=RbmI7iS27lkMZK4Z/CLCrhp2bxRTBa0N39us8T/s77MDN4NPzMsKXGh/RU3fwSnDAMMQ
	 Heo3aYzKwUalaQNmw3Iod0KByv8800+im7JOekHGSFwPVBp3Vba6rqlBiSE1+u6ClIm96
	 QGUPXQiXLASqBLFKftIePD4O0gmbO/H4zBEVO04JNodPC18xcbeQDF+dO8TpYEO1EfuW/
	 exx00NmE9Zq3NPMnINCAFp4ERUcf4aTFJNO3qzyiAeUkhVqlrGaHvm2B4L6stmhfVjVli
	 SxhICUtNkFaYFr/0qCpVoJg/OXvnYIzpy/Ti/KMs4I7TogbDvYNFJVsdEvROn8V0Ibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8vICE+7hcXSeAZX1Z36Sd6XyIa6fnGpMmUf4HKMKuzo=;
	b=5N/eqs42EfJkTHEZhF+vOIQ3esPkC0HRihTFArrD96ViWDz+nMI7DR3loVF1n73B+lif
	 f6Hlbv6T9/HChEJJBi2dECYhKEXPfjiNPaFBUIWEbiK/eFB/DdRnW8zrqyI6TJKkVWKH4
	 uBKDnrB0GdthPLXju8DDZyXIOO8ItJKRqQXOgB+yLNrQfjPf7ZIaGJmks0Fo1XMwKSkoW
	 mdIuusjThxhRyM2S4p9EStvkmSVBWcFwQWGQPev2umMF4ibsBcnnCPvgatKso/2qI1QT9
	 7eMGwJwKzpiMzM/zLxMxcoZoEE2IfwctPY83SH4BHalOC+H3OmhuXrjo70aqXrFHS8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns9m4vKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38339606B901
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns9m4vKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F094B1F00A16
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632170;
	bh=8vICE+7hcXSeAZX1Z36Sd6XyIa6fnGpMmUf4HKMKuzo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ns9m4vKOrfPat41sCkWw0o3XNuUhhbaPVG5mjcqvEy/8869KSxn/jeFT5UM1E5hfz
	 z+pLzp+NmoIPiFzw/wowMHBw2HFpM+fWq9RhhwofBngkWwgJK+inPXHk8KjJDWJdW6
	 xSaQ3GmyMIJsC4r2u9IkqSdQ26lO8HJrSQSfGSJAFOvwWfQSY9a4b6t/DjjxBUY9pU
	 v5FnQjYgWT/zbob11r74utsdMwApqeMlS09t+vGv96JeIQM5QcHK0ESTFLVwc16LkM
	 ytlnG7Wio9J16nOb5hqNlzIlA5iFjHtBSzuCSMdWLc6wS7f3UU2oVXIbV3KdeIyXs0
	 g98xx7yy8qg6A==
Message-ID: <sashiko-outbox-193635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] Landlock: Add POSIX message queue scoping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102144708.920232-4-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
 <20261102144708.920232-4-webprosto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:09:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] landlock: premature creator domain clearing in hook_inode_unlink()
- [Medium] landlock: ignored allocation failure in hook_d_instantiate() lea=
ves queue untagged
- [Medium] selftests/landlock: missing ENOSYS skip checks when CONFIG_POSIX=
_MQUEUE=3Dn
- [Low] landlock: build failure in landlock_check_posix_mqueue_open() witho=
ut tracepoints
- [Low] Documentation: landlock: section title underline too short in landl=
ock.rst
--

commit 672099a186033eeb6307163bb1baca6370e0b662
Author: Oxana Kharitonova <webprosto@gmail.com>

Landlock: Add POSIX message queue scoping

This commit introduces Posix message queue scoping in Landlock (ABI 13) to
restrict opening queues to those created within the scoping domain or its
descendants. It also adds audit logging, a denial trace event, documentatio=
n,
and selftests.

> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 1fb91884cb8af..fa65fa4aad02e 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst

[ ... ]

> @@ -1075,6 +1121,14 @@ fd-reference acquisition (:manpage:`open_tree(2)`,=
 :manpage:`fsmount(2)`) with
>  the new ``LANDLOCK_PERMISSION_NAMESPACE_USE`` permission flag and
>  ``LANDLOCK_RULE_NAMESPACE`` rule type.
> =20
> +POSIX message queue scoping (ABI < 13)
> +-------------------------------------

[Severity: Low]
This isn't a bug, but the hyphen underline here is 37 characters while the
heading above it is 38 characters. Should an extra hyphen be added so htmld=
ocs
builds do not emit a title underline warning?

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index d5dcb19d5eb19..e9c52332dfcde 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -53,6 +53,7 @@
>  #include "object.h"
>  #include "ruleset.h"
>  #include "setup.h"
> +#include "task.h"
> =20
>  #include <trace/events/landlock.h>
> =20
> @@ -1374,6 +1375,80 @@ static void hook_inode_free_security_rcu(void *ino=
de_security)
>  	WARN_ON_ONCE(inode_sec->object);
>  }
> =20
> +/*
> + * Tag a newly created POSIX message queue with its creator's domain.
> + *
> + * This is the earliest reachable point with both the creator's context =
and a
> + * fully initialized inode.
> + */
> +static void hook_d_instantiate(struct dentry *const dentry,
> +			       struct inode *const inode)
> +{
> +	struct landlock_domain *dom;
> +	struct landlock_object *object;
> +
> +	if (!landlock_is_posix_mqueue_inode(inode))
> +		return;
> +
> +	dom =3D landlock_get_current_domain();
> +	if (!dom)
> +		return;
> +
> +	object =3D get_inode_object(inode);
> +	if (IS_ERR(object))
> +		return;

[Severity: Medium]
What happens if get_inode_object(inode) fails to allocate memory in
hook_d_instantiate() when a task in a scoped domain creates a queue via
mq_open()?

Because security_d_instantiate() is a void hook called from:

    mqueue_create_attr()
      d_make_persistent()
        security_d_instantiate()
          hook_d_instantiate()

the allocation failure is ignored and the new queue is linked into mqueuefs
with no creator domain attached. Immediately afterwards, mqueue_file_open()
calls dentry_open() -> hook_file_open() -> landlock_check_posix_mqueue_open=
(),
which sees creator_domain =3D=3D NULL, treats the queue as created outside =
any
Landlock domain, and denies the creator's own mq_open() with EPERM while
leaving the untagged queue behind in the namespace.

Could the object allocation or tagging be performed in a fallible creation
hook (or preallocated before d_instantiate) so that allocation failure abor=
ts
queue creation cleanly instead of leaving an untagged queue?

> +
> +	spin_lock(&object->lock);
> +	if (WARN_ON_ONCE(object->domain)) {
> +		spin_unlock(&object->lock);
> +		landlock_put_object(object);
> +		return;
> +	}
> +
> +	landlock_get_domain(dom);
> +	object->domain =3D dom;
> +	spin_unlock(&object->lock);
> +}
> +
> +/*
> + * Drop the reference retained by hook_d_instantiate() for a POSIX messa=
ge
> + * queue once its sole name is unlinked.
> + */
> +static int hook_inode_unlink(struct inode *const dir,
> +			     struct dentry *const dentry)
> +{
> +	const struct inode *const inode =3D d_backing_inode(dentry);
> +	struct landlock_domain *domain;
> +	struct landlock_object *object;
> +
> +	if (!landlock_is_posix_mqueue_inode(inode))
> +		return 0;
> +
> +	rcu_read_lock();
> +	object =3D rcu_dereference(landlock_inode(inode)->object);
> +	/* The temporary reference protects against concurrent object release. =
*/
> +	if (!object || !refcount_inc_not_zero(&object->usage)) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +	rcu_read_unlock();
> +
> +	spin_lock(&object->lock);
> +	domain =3D object->domain;
> +	object->domain =3D NULL;
> +	spin_unlock(&object->lock);
> +
> +	/* Drop the temporary reference acquired by refcount_inc_not_zero(). */
> +	landlock_put_object(object);
> +	if (domain) {
> +		landlock_put_domain_deferred(domain);
> +		/* Drops the reference retained by hook_d_instantiate(). */
> +		landlock_put_object(object);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Can clearing object->domain inside hook_inode_unlink() strip the creator
domain from a queue that remains linked or open?

In fs/namei.c:vfs_unlink(), security_inode_unlink() is a pre-unlink
permission check:

    vfs_unlink()
      security_inode_unlink(dir, dentry)
      try_break_deleg(dir, ...)
      try_break_deleg(target, ...)
      dir->i_op->unlink(dir, dentry)

If Landlock runs before another stacked security module (such as SELinux,
AppArmor, Smack, or BPF LSM in the default lsm order) and that subsequent
module denies the unlink, or if try_break_deleg() fails, hook_inode_unlink()
has already cleared object->domain =3D NULL and dropped the retained refere=
nces,
even though vfs_unlink() aborts and the queue remains linked in mqueuefs.

Similarly, even when vfs_unlink() succeeds, the queue inode stays alive whi=
le
open file descriptors exist and can be reopened by tasks in the creator's
domain via /proc/<pid>/fd/<n>.

Because landlock_check_posix_mqueue_open() treats creator_domain =3D=3D NUL=
L as
an unsandboxed creator, any subsequent open of that queue by the creator's
own scoped domain (or a scoped ancestor domain) will be denied with EPERM.
Should the creator domain stay attached for the lifetime of the inode rather
than being cleared in hook_inode_unlink()?

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index d9eae86fc5529..0daa7edff2d7e 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -522,6 +522,72 @@ static int hook_file_send_sigiotask(struct task_stru=
ct *tsk,
>  	return -EPERM;
>  }
> =20
> +static const struct access_masks posix_mqueue_scope =3D {
> +	.scope =3D LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
> +};
> +
> +/**
> + * landlock_check_posix_mqueue_open - Deny opening a POSIX message queue
> + * created by a task from a different (non-ancestor) domain
> + *
> + * @file: The mqueuefs file being opened.
> + *
> + * Return: -EPERM if the open must be denied, 0 otherwise.
> + */
> +int landlock_check_posix_mqueue_open(struct file *const file)
> +{

[ ... ]

> +	landlock_log_denial(subject, &(struct landlock_request) {
> +		.type =3D LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
> +		.other_domain_id =3D creator_domain ? creator_domain->hierarchy->id : =
0,
> +		.audit =3D {
> +			.type =3D LSM_AUDIT_DATA_FILE,
> +			.u.file =3D file,
> +		},
> +		.layer_plus_one =3D handle_layer + 1,
> +	});

[Severity: Low]
Does security/landlock/task.c build when tracepoints are disabled?

In security/landlock/log.h, other_domain_id in struct landlock_request is
guarded by:

    #ifdef CONFIG_TRACEPOINTS
    	union {
    		u64 other_domain_id;
    ...

and in security/landlock/domain.h, creator_domain->hierarchy->id is guarded=
 by
#ifdef CONFIG_SECURITY_LANDLOCK_LOG. Because landlock_log_denial() is a sta=
tic
inline function when logging is disabled, the compound literal is still
type-checked by the compiler. Should the .other_domain_id initializer here =
be
wrapped in #ifdef CONFIG_TRACEPOINTS like in hook_unix_stream_connect() and
hook_unix_may_send()?

> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testin=
g/selftests/landlock/audit_test.c
> index 4bea8c880a4d3..a15c1e5d277f3 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c

[ ... ]

> +/* Checks audit logging and quieting of a denied POSIX message queue ope=
n. */
> +TEST_F(posix_mqueue_audit, open)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.scoped =3D LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
> +		.quiet_scoped =3D variant->quiet_scoped,
> +	};
> +	char mq_name[NAME_MAX], log_match[PATH_MAX];
> +	int pipe_parent[2], pipe_child[2], ruleset_fd, status;
> +	struct audit_records records;
> +	char buf;
> +	pid_t child;
> +	mqd_t mq;
> +
> +	ASSERT_LT(0,
> +		  snprintf(mq_name, sizeof(mq_name),
> +			   "/selftests-landlock-audit-mq-tid%d", sys_gettid()));
> +	mq_unlink(mq_name);
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +
> +	child =3D fork();
> +	ASSERT_LE(0, child);
> +	if (child =3D=3D 0) {
> +		EXPECT_EQ(0, close(pipe_parent[1]));
> +		EXPECT_EQ(0, close(pipe_child[0]));
> +
> +		mq =3D mq_open(mq_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
> +		ASSERT_LE(0, mq);

[ ... ]

> diff --git a/tools/testing/selftests/landlock/scoped_posix_msg_queue_test=
.c b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
> new file mode 100644
> index 0000000000000..4475746081bc3
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c

[ ... ]

> +	if (variant->domain_parent)
> +		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
> +
> +	mq =3D mq_open(self->mq_name, O_CREAT | O_RDWR, 0600, NULL);
> +	ASSERT_LE(0, mq);

[Severity: Medium]
In tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c, the later
tests check whether mq_open() failed with errno =3D=3D ENOSYS and call SKIP=
() when
Posix message queue support is not enabled in the kernel, but the first eig=
ht
tests (open_parent_queue, open_child_queue, open_existing_queue_with_create,
unlink_and_recreate_in_sibling_domain, open_queue_after_creator_exits,
open_queue_from_child_after_creator_exits, posix_mqueue_ipc_namespace_lifet=
ime,
and create_and_open_same_domain) along with TEST_F(posix_mqueue_audit, open)
in tools/testing/selftests/landlock/audit_test.c assert that mq_open()
succeeds directly.

Should those tests also skip when mq_open() fails with ENOSYS so they do not
fail on kernels built without Posix message queue support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144708.9202=
32-1-webprosto@gmail.com?part=3D3
