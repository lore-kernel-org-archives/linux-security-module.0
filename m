Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D9376A19
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391859; cv=none; b=qmkwL49Qgv5lH1CFCKx2uAlK/ZOUj2NsUsS4vIUxagtwlf5dsbnk844gzZ1izmyUU5rE3Vz/do2OFAC8amE7r5Ds2OgtzE2Q5OvAZFardATBfMp8iFy3nFEoKO77vanHrDtSFn49EZHGYQVdov5bQZEa2uMiNJkO4bH8SrgkZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391859; c=relaxed/simple;
	bh=3r0pCpBSEptVHBr59f1zhosRG2XBhmLXItK/DBzhJ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhJOLEQl6o6XQseiQuSvIN0le0tA7Sn0NOxIvyjT8ZkuSzol5pYYu2gwZzgzfZKt6mrnkXNMDZDdQvwV2fQsRaWhMQy3LTqnGW7du+YaNCLqG+RGJKfaxqYhj/lxhjEHL1Pbx+hWc0CL9vXv4Yt1Al2s589WkxmjzUHZzROesNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozfRMdhk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozfRMdhk"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3749611a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787391856; x=1787996656; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWXN+LsGTbtN5NpR/5hZetypQ75mLg2EuqRMH1IUCeQ=;
        b=ozfRMdhkr6RKe4oA8nTJjIIhzTNBMpHwaustof9gLSr989abeXVqyaOJ9n9KLvC+Qf
         gykFkzcpde1SEgJQeduwv8r4sIlKMtpwMydPvue8NHdlEEcSlKmKW9Ph5ZBLBSJTJ4j0
         /KxG+J+cNwOBXA9X9O6oeS3Ml0KV5Uy5cWhJ3GNE3/t6/cIjpKW6MdsBNSVfjbTMxnCS
         lwQHR2+U3vWd+Qbu15k8Mtl8QAYUPVvxhGcn4MEXdAE4YwyD8bnbZcyAL7AV4aktxJKT
         u7/7QzyD0ZoUqJDSl/ZIv+mz4f6c98WJWPazf08Auuw3hGmeyCnHPdzGEoS5xWTolZGG
         92+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787391856; x=1787996656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CWXN+LsGTbtN5NpR/5hZetypQ75mLg2EuqRMH1IUCeQ=;
        b=dkTm3EePoD1YiCK2jBYmVrihDkoD0VBvVZbw4EDWhbiJgABlVny2dlIrC4yblrPXGP
         FrcNN0kAAUmoQtGzbteSEC6X+haJWxxPmNTgKhdpHXobK6mkTa65OAWTzFGOOV+dCM2q
         m1gxKVlIbQSa4SFIVbITvNEkDGwe92x7/AdSJ3s7YjZfH6F3nkfLHngK3XMdl07bfLK9
         w7+fzO3c5DqBpO5ZC0DhuTi/RpFJdGzBwikJ6b3d32tzaBAT7r2bXoVTFi7xCUANlYWV
         KCVFHTE646Aw3fHXq277oBgG1seBv5Kc0Fz7Z/jXSj2wbnjjCFRtAf92SYE5a3ggRyZW
         0mdw==
X-Forwarded-Encrypted: i=1; AHgh+RqF1kMWzoV6C23zys5aLzKAwgokPHQmaLRUD1LkJKTy6Qr4HH771oztwGBlLAHStJHxp4E9Qs9jI080u/Kz50P++zvivvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nvKU9lHS5uyA7dBsqskgTpBtjclpZ0k5mTkPlROYx4Uk4UfBIN
	9vY0eSCkQ5UVNx+V0NvQ68NvKvjkee32ynzScq7hCY3Rx/rfiBhk3kpJ0U4cevlA
X-Gm-Gg: AR+sD11wA2zY8ST0ZAen+U947VAz479ncPJyuv2JkzrZJ/CQuInYW2rPlEd95Ecc4YL
	3AqIh9rujyD0J1FLjACdUJO47JfszNTudBobxuMvjNHvto3av0If6PHL+l+AcdIKodf2TJBv+L2
	G1aIppTpPXf1pa8AmP7UeHOBa7+1E1mlLet+tdbV2PsxzWU88hdxSOrSSUVTwhGLn8/GkcA9iIV
	qF5xplfBAytRI3CtKcjH6KfFxKIbzFoJXCPWTBLoSwd3OmxMyOEFNufcTBrwLFZBol4SqQtijkS
	SDND7rkky1L2lBRqJ7+Ny37tjgzVLRD2fqszyGOprbdPD6Ki5CyxZP+Qort1pOe+gHWhKC/2Rin
	ZSNspIZbxBiFdK85P2pExUVgYTrIkSzp5JISFteg39t5gVOZe8v2Ku9sHN98M3wx3Bfza3Hq9Dt
	z4cSnXgvKq2VMitvtEKNQZMgAUmh+LEhmgwpMEStFlddAsy0eRH8YYiZxvAYP6ZUEaao6yv1xZe
	mAnW2PDwGuHuw==
X-Received: by 2002:a05:6402:444a:b0:698:351c:979c with SMTP id 4fb4d7f45d1cf-6a42f16f016mr15134707a12.2.1787391855454;
        Sat, 22 Aug 2026 02:44:15 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff178289sm11322478a12.30.2026.08.22.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 02:44:14 -0700 (PDT)
Date: Sat, 22 Aug 2026 11:44:08 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/6] selftests/landlock: Test
 LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Message-ID: <20260822.6e90a5c8196c@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260727230833.138165-5-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727230833.138165-5-utilityemal77@gmail.com>

Hello!

On Mon, Jul 27, 2026 at 07:08:31PM -0400, Justin Suess wrote:
> Add selftests for SysV message queue scoped right.
> 
> Use the existing scoped domain harness for msgget, and another fixture
> for testing msgsnd, msgrcv and msgctl.
> 
> Pass the msqid around for coverage of non-msgget syscalls, since calling
> msgget while already restricted would fail and prevent testing the
> operation under test.
> 
> Denials are checked against -EACCES rather than -EPERM: msgget,
> msgsnd, msgrcv and msgctl(IPC_STAT) all reach the Landlock scope
> check via ipcperms(), whose callers map every non-zero return into
> -EACCES before propagating it to user space.
> 
> Track the created msqid in the fixture and remove it from
> FIXTURE_TEARDOWN_PARENT() so that queues are reclaimed even when a
> failed assertion aborts a test, and so that the removal is never
> subject to the scoping under test.
> 
> Also add CONFIG_SYSVIPC to the selftest config fragment since the new
> test requires SysV IPC support.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  tools/testing/selftests/landlock/config       |   1 +
>  .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
>  2 files changed, 266 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> 
> diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
> index 8fe9b461b1fd..8acb03464df4 100644
> --- a/tools/testing/selftests/landlock/config
> +++ b/tools/testing/selftests/landlock/config
> @@ -15,5 +15,6 @@ CONFIG_SECURITY=y
>  CONFIG_SECURITY_LANDLOCK=y
>  CONFIG_SHMEM=y
>  CONFIG_SYSFS=y
> +CONFIG_SYSVIPC=y
>  CONFIG_TMPFS=y
>  CONFIG_TMPFS_XATTR=y
> diff --git a/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> new file mode 100644
> index 000000000000..91a560c957e6
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - SysV Message Queue Scoping
> + *

Extraneous blank comment line here; did you mean to add a Copyright
line here?

> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/landlock.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "common.h"
> +#include "scoped_common.h"
> +
> +/*
> + * Removes the message queue identified by @msqid, ignoring any error since
> + * the caller might no longer have permission to operate on it (for example,
> + * after entering a scoped domain).
> + */
> +static void cleanup_msg_queue(int msqid)
> +{
> +	if (msqid >= 0)
> +		msgctl(msqid, IPC_RMID, NULL);
> +}
> +
> +FIXTURE(scoped_domains)
> +{
> +	int msqid;
> +};
> +
> +#include "scoped_base_variants.h"
> +
> +FIXTURE_SETUP(scoped_domains)
> +{
> +	self->msqid = -1;
> +	drop_caps(_metadata);
> +}
> +
> +/*
> + * The queue is removed by the (never sandboxed) test harness parent, which
> + * also runs when an assertion aborts the test after the queue got created.
> + */
> +FIXTURE_TEARDOWN_PARENT(scoped_domains)
> +{
> +	cleanup_msg_queue(self->msqid);
> +}
> +
> +/*
> + * Parent creates a SysV message queue, then the child tries to associate
> + * with it via msgget(2).  When the child is in a domain that scopes message
> + * queues and the parent is not in that same scope, the association must be
> + * denied with -EACCES (msgget runs the scope check via ipcperms(), which
> + * masks every denial as -EACCES).
> + */
> +TEST_F(scoped_domains, check_access_msg_queue)
> +{
> +	pid_t child;
> +	int status;
> +	int pipe_parent[2], pipe_child[2];
> +	char buf;
> +	key_t key;
> +	bool can_associate;
> +
> +	/*
> +	 * The child can associate with the parent's queue unless the child
> +	 * is in a scoped domain that does not include the parent (i.e. the
> +	 * parent is outside the child's domain).
> +	 */
> +	can_associate = !variant->domain_child;
> +
> +	/*
> +	 * Picks a per-test key derived from PID to avoid collisions.  Stale
> +	 * queues from a previous run are unlikely but handled by removing
> +	 * any matching entry before applying any scope.
> +	 */
> +	key = (key_t)(getpid() & 0x7fffffff);

Is that supported? :)

Michael Kerrisk's Linux Programming Interface book only covered ftok()
and IPC_PRIVATE.  In my understanding, if you pass IPC_PRIVATE to
msgget(), you are guaranteed to get a new queue?  You are using that
in the other test below as well.  Isn't that what you want?


> +	cleanup_msg_queue(msgget(key, 0));
> +
> +	if (variant->domain_both)
> +		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
> +
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int ret;
> +
> +		EXPECT_EQ(0, close(pipe_child[0]));
> +		EXPECT_EQ(0, close(pipe_parent[1]));
> +
> +		if (variant->domain_child)
> +			create_scoped_domain(_metadata,
> +					     LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
> +
> +		/* Signals readiness to the parent. */
> +		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +		EXPECT_EQ(0, close(pipe_child[1]));
> +
> +		/* Waits for the parent to have created the queue. */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
> +		EXPECT_EQ(0, close(pipe_parent[0]));
> +
> +		ret = msgget(key, 0);
> +		if (can_associate) {
> +			ASSERT_LE(0, ret);
> +		} else {
> +			ASSERT_EQ(-1, ret);
> +			/*
> +			 * msgget uses ipcperms(), which masks every LSM
> +			 * denial as -EACCES regardless of the value the
> +			 * LSM hook returns.
> +			 */
> +			ASSERT_EQ(EACCES, errno);
> +		}

Testing nit: The checks on the msgget() results should probably be an
EXPECT_*() variant. ASSERT_*() should only be used when continuing to
run the test doesn't otherwise make sense.

Compare https://google.github.io/googletest/reference/assertions.html:

    The majority of the macros listed below come as a pair with an
    EXPECT_ variant and an ASSERT_ variant. Upon failure, EXPECT_
    macros generate nonfatal failures and allow the current function
    to continue running, while ASSERT_ macros generate fatal failures
    and abort the current function.


> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +	EXPECT_EQ(0, close(pipe_child[1]));
> +	EXPECT_EQ(0, close(pipe_parent[0]));
> +
> +	if (variant->domain_parent)
> +		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
> +
> +	/* Waits for the child to be ready. */
> +	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
> +	EXPECT_EQ(0, close(pipe_child[0]));
> +
> +	self->msqid = msgget(key, IPC_CREAT | IPC_EXCL | 0600);
> +	ASSERT_LE(0, self->msqid);
> +
> +	/* Releases the child. */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	EXPECT_EQ(0, close(pipe_parent[1]));
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +/*
> + * The msg_queue_associate hook (exercised by msgget(2)) is covered by the
> + * scoped_domains fixture above.  The remaining hooks all funnel through the
> + * same scope check, so it suffices to verify that each operation is denied
> + * when the child is scoped relative to the queue's creator.
> + *
> + * To attribute a denial to the operation under test (and not to a preceding
> + * msgget(2) call), the parent creates the queue and the child inherits the
> + * msqid across fork(2), bypassing msg_queue_associate.
> + */
> +enum msg_op {
> +	MSG_OP_SND,
> +	MSG_OP_RCV,
> +	MSG_OP_CTL,
> +};
> +
> +FIXTURE(scoping_msg_ops)
> +{
> +	int msqid;
> +};
> +
> +FIXTURE_VARIANT(scoping_msg_ops)
> +{
> +	enum msg_op op;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(scoping_msg_ops, msgsnd) {
> +	/* clang-format on */
> +	.op = MSG_OP_SND,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(scoping_msg_ops, msgrcv) {
> +	/* clang-format on */
> +	.op = MSG_OP_RCV,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(scoping_msg_ops, msgctl) {
> +	/* clang-format on */
> +	.op = MSG_OP_CTL,
> +};
> +
> +FIXTURE_SETUP(scoping_msg_ops)
> +{
> +	self->msqid = -1;
> +	drop_caps(_metadata);
> +}
> +
> +/* See the scoped_domains teardown comment. */
> +FIXTURE_TEARDOWN_PARENT(scoping_msg_ops)
> +{
> +	cleanup_msg_queue(self->msqid);
> +}
> +
> +TEST_F(scoping_msg_ops, deny_op)
> +{
> +	struct msgbuf {
> +		long mtype;
> +		char mtext[1];
> +	} msg = { .mtype = 1 };
> +	struct msqid_ds ds;
> +	pid_t child;
> +	int status;
> +	int ret = 0;
> +
> +	/*
> +	 * The child inherits the msqid across fork(2), so no key is needed:
> +	 * IPC_PRIVATE always creates a new queue and cannot collide with
> +	 * queues left over by other processes.
> +	 */
> +	self->msqid = msgget(IPC_PRIVATE, 0600);
> +	ASSERT_LE(0, self->msqid);
> +
> +	/* Preloads a message so msgrcv(2) would otherwise succeed. */
> +	ASSERT_EQ(0, msgsnd(self->msqid, &msg, sizeof(msg.mtext), 0));
> +
> +	child = fork();

I do not understand why this test needs to fork() at all, tbh.
If you were to

* create the queue with msgget(),
* add a message with msgsnd(),
* then enter the Landlock domain (still in the same process),
* and then check for the operation failure

Wouldn't that also fail?  After all, the message queue was created at
a point in time when the process was still unrestricted, so we should
be comparing to the Landlock state at that earlier point in time, no?

> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
> +
> +		switch (variant->op) {
> +		case MSG_OP_SND:
> +			ret = msgsnd(self->msqid, &msg, sizeof(msg.mtext), 0);
> +			break;
> +		case MSG_OP_RCV:
> +			ret = msgrcv(self->msqid, &msg, sizeof(msg.mtext), 0,
> +				     IPC_NOWAIT);
> +			break;
> +		case MSG_OP_CTL:
> +			ret = msgctl(self->msqid, IPC_STAT, &ds);
> +			break;
> +		}
> +		ASSERT_EQ(-1, ret);

If these operations are all supposed to fail (and presumably be
no-ops), is it necessary to still use a fixture with multiple cases
for that?  (The alternative would be to make this a regular TEST()
without fixtures and do the three failing operations one after
another. It would save you a lot of macro boilerplate and the special
enum, and would make the test more direct IMHO.)

> +		/*
> +		 * msgsnd, msgrcv and msgctl(IPC_STAT) all reach the
> +		 * Landlock scope check via ipcperms(), whose callers map
> +		 * any non-zero return into -EACCES before propagating it
> +		 * to user space.
> +		 */
> +		ASSERT_EQ(EACCES, errno);
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.54.0
> 

–Günther
