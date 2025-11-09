Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CC305E1B
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708520; cv=none; b=kJY1k4hrNkwamkfIEGL+Kl9YWN0Jqu4aEV6jD+sjfXJ14XYoXgc82OXONuXLRavtA0W1TA67ibMDYhVNQ0M7Af/vkFaNXHpOn4CHmxQe3gnoYue1lIPqdw/fJOY+agwTgxoxXtQfSxR1EXaW+P4nqR5LnXAkVZVCrSo+q21l3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708520; c=relaxed/simple;
	bh=5WYlPL0F3A1t+zKDUiKYdZay1vJaUmu4Ud0oSWVXAoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LLUtDp/6HQzfg3nWvFPOTqrFEHQ6AEhqYL5MCQxY41S+x3Kv0QVo4yRqW73DgFTYrz5oF/3fAUfikdIqrSu04TloM0kJdTNeKqMLLLFALX42ZvHWgnElZcBu4PhZ3GJPutMKQdQe61TKTPnG5Twi5TRWXiYADZIaW4BE+qHKrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUhBEpts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUhBEpts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762708517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH23Ki9EOjG++XfGf0hWyR5UKo/5fVuG3elhs2g375Y=;
	b=JUhBEptsOwwFk/ONCs1h7G0txVLxDvyp/M0LbBcuClNlx4Lb1M13b261f7s3U1eDtypfX4
	I2/Xu+VUcxN7A1+O8RcrYLyfCHTuvU43qQ5qHo2Ed4EogQ7TxAi3SUc0ni4xEGwNJ1kti3
	v5gP35TmqZe6AHOp8wOLwIbjEwMjfVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-CuZae3GcMvOAScHKC0TWrQ-1; Sun,
 09 Nov 2025 12:15:16 -0500
X-MC-Unique: CuZae3GcMvOAScHKC0TWrQ-1
X-Mimecast-MFC-AGG-ID: CuZae3GcMvOAScHKC0TWrQ_1762708515
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D3CB195608F;
	Sun,  9 Nov 2025 17:15:15 +0000 (UTC)
Received: from fedora (unknown [10.44.32.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C8655180087B;
	Sun,  9 Nov 2025 17:14:53 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Nov 2025 18:15:14 +0100 (CET)
Date: Sun, 9 Nov 2025 18:14:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Levin <ldv@strace.io>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 1/3] exec: make setup_new_exec() return int
Message-ID: <aRDMDLgLdYq9g1Tr@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aRDL3HOB21pMVMWC@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PD2Wh6YQ6E0wZye_xp0QpZBdjfbQ_HYhzG7m0eQoxPE_1762708515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Preparation. After the next change setup_new_exec() can fail.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/binfmt_elf.c         | 4 +++-
 fs/binfmt_elf_fdpic.c   | 4 +++-
 fs/binfmt_flat.c        | 4 +++-
 fs/exec.c               | 4 +++-
 include/linux/binfmts.h | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e4653bb99946..8a38689ae4b0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1021,7 +1021,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
-	setup_new_exec(bprm);
+	retval = setup_new_exec(bprm);
+	if (retval)
+		goto out_free_dentry;
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca0..7ad98b8132fc 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -351,7 +351,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	setup_new_exec(bprm);
+	retval = setup_new_exec(bprm);
+	if (retval)
+		goto error;
 
 	set_binfmt(&elf_fdpic_format);
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b5b5ca1a44f7..78e9ca128ea7 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -512,7 +512,9 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 	/* OK, This is the point of no return */
 	set_personality(PER_LINUX_32BIT);
-	setup_new_exec(bprm);
+	ret = setup_new_exec(bprm);
+	if (ret)
+		goto err;
 
 	/*
 	 * calculate the extra space we need to map in
diff --git a/fs/exec.c b/fs/exec.c
index 6b70c6726d31..136a7ab5d91c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1321,7 +1321,7 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 }
 EXPORT_SYMBOL(would_dump);
 
-void setup_new_exec(struct linux_binprm * bprm)
+int setup_new_exec(struct linux_binprm * bprm)
 {
 	/* Setup things that can depend upon the personality */
 	struct task_struct *me = current;
@@ -1337,6 +1337,8 @@ void setup_new_exec(struct linux_binprm * bprm)
 	me->mm->task_size = TASK_SIZE;
 	up_write(&me->signal->exec_update_lock);
 	mutex_unlock(&me->signal->cred_guard_mutex);
+
+	return 0;
 }
 EXPORT_SYMBOL(setup_new_exec);
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836..678b7525ac5a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -123,7 +123,7 @@ extern void unregister_binfmt(struct linux_binfmt *);
 
 extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int begin_new_exec(struct linux_binprm * bprm);
-extern void setup_new_exec(struct linux_binprm * bprm);
+extern int setup_new_exec(struct linux_binprm * bprm);
 extern void finalize_exec(struct linux_binprm *bprm);
 extern void would_dump(struct linux_binprm *, struct file *);
 
-- 
2.25.1.362.g51ebf55


