Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5A286D55
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299144; cv=none; b=S4GP4ecw/QTwhRjCdl8b/o5EQwRd2uqNfcSB62ywKnNtFSI2AcoLphH/xiESI5L2vD2kag6WHjGrHXZaXybfUgxEyezP9xCwOiWTQ2WCJFdWm0Yy9pyzIxb3AUkQ1l/02hYmHPVJHB/g0yomTkyYH0iNaYNzpdpfozTQ44QJaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299144; c=relaxed/simple;
	bh=Nthldf7lbRoMz/nlz/JOadJ9gCSkTx7qUh5lKZ+u5Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KY0Ys0eVj7HuUjZsbPjtsCtEBJD9Wr+DgCzfkLtAjZK2tpD0uk2rd1q6UpG3YxuvSBDkGyreRE8/focGhsCmOKpwZHpY4heD8Dm334QqXnbVLNTF1j0v8EUUQCytc4Lg85EUe2Us3SC+H7zxo/orGbeqNS5iW2OXK+EPIk7YpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcwkjb8d; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcwkjb8d"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4362456500eso776169f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770299142; x=1770903942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAmLG57j8Rj3itBaST86JcST4zg6YUNTubfQVh5YLWw=;
        b=pcwkjb8d5Z/RbTXHqfYViJSWEmzkkM6RCaILT4xMghnOJCQST/NnFuyBQhgoyZN5wD
         fNqg1fJA4fdTKn2cpn+kE7P3FE2bqUY7fSX46dD7gqW8h8Bfys8oPjOA5Fo9E1Q9nGsW
         1FHjvF04I2+CDD+oc9SlHLSlK5COsL4sDraSDjincPeVZPtGpYH8URpD4MXLytXvmBhf
         3jpwyiaL73k4DP9nq7Agw8R5KlFXdaHJSFzi3LdpMHdt8R+pam0BHkKdMC4o0EzD+bes
         p2iWBwABn5Ixc7iJ8qNve7DClAsRDvPiA+sv0sGsghKDBvVvP9h2cKE0e5zDRVAnKC1Q
         WA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299142; x=1770903942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAmLG57j8Rj3itBaST86JcST4zg6YUNTubfQVh5YLWw=;
        b=MeopgGYY7aIxJA1XJEguk9FSYvCqcInqSDCX10tPI3IFfM9Ts3rHkwO7UpQBEOxY+t
         uEw4iqB4qklFsu1MtpDgBSA7SAgHdYD3bMsYX3O/rIANH5gm/ZAVwAJp3j180hel6Ga3
         Djo4Wjm+M9OWCV0+HLto4llTyjH9YuzDaBujHjmsE5O56PXkpYglNAJvMAj9CpyCl1gb
         ec47XwAIptkC1JbQc2SS/I7QDK903AN85te0Ewpv1TrGTIKb9r9aPKBUqF7JMnRrX1Ou
         ddsWt1Y2kNLDpQEi33jAegXk2W5bHJCCrViW25L6rY3sp5k/mpNwJ7ckP2+WEgrQjvaT
         s45w==
X-Forwarded-Encrypted: i=1; AJvYcCUDQ+1V2JZbDUF6Dhb1DNKB80OXyw0wUo62tyqjCitrmOrvsrYXXBiLDfnDRKDY7D7DaUWYX4utvZH7GRA//vjayykEVUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXCU8LvpMCqoHMD/EIIhZe2DMu3zcHez29+Mmh7o1gmDysJmF
	wJsIfjXi8kosOwM57g3vtKSvQpK6Kip9xnF42dNQjgynWLbiHhv0GTxYkd+WeQhReiB4Pl9SPhX
	mD/hEkLJY4WtEuYAcyA==
X-Received: from wrbfq11.prod.google.com ([2002:a05:6000:2a0b:b0:430:f303:97d3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4283:b0:431:48f:f78f with SMTP id ffacd0b85a97d-43617e387a3mr8591141f8f.1.1770299141977;
 Thu, 05 Feb 2026 05:45:41 -0800 (PST)
Date: Thu, 5 Feb 2026 13:45:40 +0000
In-Reply-To: <9a037fdf-1a98-437f-8b80-7fdc53d5b0fa@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com> <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
 <aYSCNur71BJJeB2Q@google.com> <9a037fdf-1a98-437f-8b80-7fdc53d5b0fa@lucifer.local>
Message-ID: <aYSfBJA4hR4shPfI@google.com>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 11:53:19AM +0000, Lorenzo Stoakes wrote:
> On Thu, Feb 05, 2026 at 11:42:46AM +0000, Alice Ryhl wrote:
> > On Thu, Feb 05, 2026 at 11:20:33AM +0000, Lorenzo Stoakes wrote:
> > > On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> > > > This exports the functionality needed by Binder to close file
> > > > descriptors.
> > > >
> > > > When you send a fd over Binder, what happens is this:
> > > >
> > > > 1. The sending process turns the fd into a struct file and stores it in
> > > >    the transaction object.
> > > > 2. When the receiving process gets the message, the fd is installed as a
> > > >    fd into the current process.
> > > > 3. When the receiving process is done handling the message, it tells
> > > >    Binder to clean up the transaction. As part of this, fds embedded in
> > > >    the transaction are closed.
> > > >
> > > > Note that it was not always implemented like this. Previously the
> > > > sending process would install the fd directly into the receiving proc in
> > > > step 1, but as discussed previously [1] this is not ideal and has since
> > > > been changed so that fd install happens during receive.
> > > >
> > > > The functions being exported here are for closing the fd in step 3. They
> > > > are required because closing a fd from an ioctl is in general not safe.
> > > > This is to meet the requirements for using fdget(), which is used by the
> > > > ioctl framework code before calling into the driver's implementation of
> > > > the ioctl. Binder works around this with this sequence of operations:
> > > >
> > > > 1. file_close_fd()
> > > > 2. get_file()
> > > > 3. filp_close()
> > > > 4. task_work_add(current, TWA_RESUME)
> > > > 5. <binder returns from ioctl>
> > > > 6. fput()
> > > >
> > > > This ensures that when fput() is called in the task work, the fdget()
> > > > that the ioctl framework code uses has already been fdput(), so if the
> > > > fd being closed happens to be the same fd, then the fd is not closed
> > > > in violation of the fdget() rules.
> > >
> > > I'm not really familiar with this mechanism but you're already talking about
> > > this being a workaround so strikes me the correct thing to do is to find a way
> > > to do this in the kernel sensibly rather than exporting internal implementation
> > > details and doing it in binder.
> >
> > I did previously submit a patch that implemented this logic outside of
> > Binder, but I was advised to move it into Binder.
> 
> Right yeah that's just odd to me, we really do not want to be adding internal
> implementation details to drivers.
> 
> This is based on bitter experience of bugs being caused by drivers abusing every
> interface they get, which is basically exactly what always happens, sadly.
> 
> And out-of-tree is heavily discouraged.
> 
> Also can we use EXPORT_SYMBOL_FOR_MODULES() for anything we do need to export to
> make it explicitly only for binder, perhaps?
> 
> >
> > But I'm happy to submit a patch to extract this logic into some sort of
> > close_fd_safe() method that can be called even if said fd is currently
> > held using fdget().
> 
> Yup, especially given Christian's view on the kernel task export here I think
> that's a more sensible approach.
> 
> But obviously I defer the sensible-ness of this to him as I am but an mm dev :)

Quick sketch of how this would look:

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index adde1e40cccd..6fb7175ff69b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -64,7 +64,6 @@
 #include <linux/spinlock.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
-#include <linux/task_work.h>
 #include <linux/sizes.h>
 #include <linux/ktime.h>
 
@@ -1962,68 +1961,6 @@ static bool binder_validate_fixup(struct binder_proc *proc,
 	return (fixup_offset >= last_min_offset);
 }
 
-/**
- * struct binder_task_work_cb - for deferred close
- *
- * @twork:                callback_head for task work
- * @file:                 file to close
- *
- * Structure to pass task work to be handled after
- * returning from binder_ioctl() via task_work_add().
- */
-struct binder_task_work_cb {
-	struct callback_head twork;
-	struct file *file;
-};
-
-/**
- * binder_do_fd_close() - close list of file descriptors
- * @twork:	callback head for task work
- *
- * It is not safe to call ksys_close() during the binder_ioctl()
- * function if there is a chance that binder's own file descriptor
- * might be closed. This is to meet the requirements for using
- * fdget() (see comments for __fget_light()). Therefore use
- * task_work_add() to schedule the close operation once we have
- * returned from binder_ioctl(). This function is a callback
- * for that mechanism and does the actual ksys_close() on the
- * given file descriptor.
- */
-static void binder_do_fd_close(struct callback_head *twork)
-{
-	struct binder_task_work_cb *twcb = container_of(twork,
-			struct binder_task_work_cb, twork);
-
-	fput(twcb->file);
-	kfree(twcb);
-}
-
-/**
- * binder_deferred_fd_close() - schedule a close for the given file-descriptor
- * @fd:		file-descriptor to close
- *
- * See comments in binder_do_fd_close(). This function is used to schedule
- * a file-descriptor to be closed after returning from binder_ioctl().
- */
-static void binder_deferred_fd_close(int fd)
-{
-	struct binder_task_work_cb *twcb;
-
-	twcb = kzalloc(sizeof(*twcb), GFP_KERNEL);
-	if (!twcb)
-		return;
-	init_task_work(&twcb->twork, binder_do_fd_close);
-	twcb->file = file_close_fd(fd);
-	if (twcb->file) {
-		// pin it until binder_do_fd_close(); see comments there
-		get_file(twcb->file);
-		filp_close(twcb->file, current->files);
-		task_work_add(current, &twcb->twork, TWA_RESUME);
-	} else {
-		kfree(twcb);
-	}
-}
-
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
@@ -2183,7 +2120,10 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 						offset, sizeof(fd));
 				WARN_ON(err);
 				if (!err) {
-					binder_deferred_fd_close(fd);
+					/*
+					 * Intentionally ignore EBADF errors here.
+					 */
+					close_fd_safe(fd, GFP_KERNEL | __GFP_NOFAIL);
 					/*
 					 * Need to make sure the thread goes
 					 * back to userspace to complete the
diff --git a/fs/file.c b/fs/file.c
index 0a4f3bdb2dec..58e3825e846c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
 #include <linux/file_ref.h>
+#include <linux/task_work.h>
 #include <net/sock.h>
 #include <linux/init_task.h>
 
@@ -1525,3 +1526,47 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+struct close_fd_safe_task_work {
+	struct callback_head twork;
+	struct file *file;
+};
+
+static void close_fd_safe_callback(struct callback_head *twork)
+{
+	struct close_fd_safe_task_work *twcb = container_of(twork,
+			struct close_fd_safe_task_work, twork);
+
+	fput(twcb->file);
+	kfree(twcb);
+}
+
+/**
+ * close_fd_safe - close the given fd
+ * @fd: file descriptor to close
+ * @flags: gfp flags for allocation of task work
+ *
+ * This closes an fd. Unlike close_fd(), this may be used even if the fd is
+ * currently held with fdget().
+ *
+ * Returns: 0 or an error code
+ */
+int close_fd_safe(unsigned int fd, gfp_t flags)
+{
+	struct close_fd_safe_task_work *twcb;
+
+	twcb = kzalloc(sizeof(*twcb), flags);
+	if (!twcb)
+		return -ENOMEM;
+	init_task_work(&twcb->twork, close_fd_safe_callback);
+	twcb->file = file_close_fd(fd);
+	if (!twcb->file) {
+		kfree(twcb);
+		return -EBADF;
+	}
+
+	get_file(twcb->file);
+	filp_close(twcb->file, current->files);
+	task_work_add(current, &twcb->twork, TWA_RESUME);
+	return 0;
+}
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..1c99a56c0cdf 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -111,6 +111,7 @@ int iterate_fd(struct files_struct *, unsigned,
 		const void *);
 
 extern int close_fd(unsigned int fd);
+extern int close_fd_safe(unsigned int fd, gfp_t flags);
 extern struct file *file_close_fd(unsigned int fd);
 
 extern struct kmem_cache *files_cachep;
