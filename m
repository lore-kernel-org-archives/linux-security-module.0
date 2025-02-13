Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7423A9B1
	for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448010; cv=none; b=h2GpK95QpJ8Ipz/5ozGitiyQqZq1PDDY83n8kT1o8YCp/S+dmKy1fc2cZRQ0hpmb0uwRc3Bx/ZG+b2rCC6WNroXOQHyUAASqLz4DV0W+KSwQe4M0oMxvmMdEuiWIYNfsV+6K6Qtr+N1BEpV78ZkTxB+lYF1fJcxZmbAoZ8WK/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448010; c=relaxed/simple;
	bh=jO0lN5x9guXp1a4LurUsJQThejvJaKRkotHrdOiQ9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW7tJDXMt9Vp8yjVYzTJvQEaPH6g3UccfxYMNUZrPx/ZPOqR55exfCighSlw3jf8rJvod35mNLninT7FGo/c+7fZKMTSF26LcVnPDGMTDc5qJbiXVnE4FhTRzM1RVkSwKQeJ+2+4hC8z3h6Repy/JVFzD6lMdGkws+e9/HXsqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Dg/FZGLk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Dg/FZGLk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fee2b9c7aso5920311cf.2
        for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2025 04:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739448006; x=1740052806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=Dg/FZGLkaZ7ie6M7KfJ0TS6y+1v6GfledRzDEjzhrFVkV7uxrcCLh+GQvS5H4KHXL8
         B51WJr8ZenjcTJprsEiiDlKCbKsZzxvg9FvDFhorRi45bII61nN42/Ul+A/gOXOVchwk
         Bary65zTIufxEg3GLS9b65341xcV8kC1py7lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448006; x=1740052806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=GWLzZBqbvbbKkCDP2VewMi4GZ3GLsmorVIKhj90PuVyTkE5TWLFJLfMrMFe12+V5S+
         DsGtuEsa7ZupdCDxiDpYxB3icd7NS1nV3VetizzMhnm93MahhTttk6+s/voMT0hXaJkF
         BaUrO9/E5p316vYG52k/gXXguwCZiRefW8pIBv2FoojRwthFhIcoiTDrPWPBROuLrjK2
         xvQNP3MgiW8sDiyqQwH3op5LWSvhubGF/nKa3bTX5lxXBESVYER/pOtmpu6+8hGcT+6F
         8/2iTgcwyPFKEXE5iF9UQfR3nDWqK4qlKU5ujj+uT5PWzzh3d/0sFJJW8U3V61TS4HRc
         nBUA==
X-Forwarded-Encrypted: i=1; AJvYcCWXydGGeXzoIZGqfxKx/0r7UN/eZyc7BBNYm7vhn/Ei4MBmH9rstY4Fjw/JfjoHGRTFJ1RqlQw/p14vo2gw+UiUqqts+cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJzqAA7upvbuInMjpk4c0gAZFcrWoPqeuisusdfk3O63G35RV
	Zfkyd9bf/TqZpfJyPa6lN/8NS7ax6Uxozo0xftULqjcUimE/jcvQpk4oSdoJTj39GCyLq6gTjMK
	qrX0R7cnv382elLAqHiG806qgF1qsKoJr0OI3pw==
X-Gm-Gg: ASbGncsUNcuG9U+J/uuMXYGcbyaO3FOhfUxmaHffr8Oehu6Zn6O6NrCx9yg6Nc6/sgX
	FOYIK68GqD89lShijgRiVKRh8+IRKTQ5jg26XoweOXrAcICm/NzBJjZOtTC7KkHlGD1AuGQ==
X-Google-Smtp-Source: AGHT+IECakDoTpDhiyRznxkiGj71HtCaKMx16upveVIQZiceah1ZrEWHrFOAhOuh92zW9TRY+grheUmpzNv0IRyez9s=
X-Received: by 2002:ac8:7e96:0:b0:471:bbdb:9f43 with SMTP id
 d75a77b69052e-471bbdba074mr60632641cf.24.1739448006112; Thu, 13 Feb 2025
 04:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
In-Reply-To: <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Feb 2025 12:59:55 +0100
X-Gm-Features: AWEUYZlbIShCppFI0DHhIK5cm-ltnuxnlVq8Qowgi16SzeDjxo4poRs6xazAudA
Message-ID: <CAJfpegs2qoZHG4P+WiopDo92MxHQ_0QrZi0qMz7niannGFiPDQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 16:50, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-01-25 17:58:00, Miklos Szeredi wrote:

> >       fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> > +     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>
> I understand why you need this but the condition is really hard to
> understand now and the comment above it becomes out of date. Perhaps I'd
> move this and the following two checks for FAN_RENAME and
> FANOTIFY_PRE_CONTENT_EVENTS into !FAN_GROUP_FLAG(group, FAN_REPORT_MNT)
> branch to make things more obvious?

Okay.  git diff -w below.

Thanks,
Miklos

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1936,6 +1936,8 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
             mark_type != FAN_MARK_INODE)
                return -EINVAL;

+       /* The following checks are not relevant to mount events */
+       if (!FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
                /*
                 * Events that do not carry enough information to report
                 * event->fd require a group that supports reporting fid.  Those
@@ -1944,21 +1946,25 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
                 * point.
                 */
                fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-       if (mask &
~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+               if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
                    (!fid_mode || mark_type == FAN_MARK_MOUNT))
                        return -EINVAL;

                /*
-        * FAN_RENAME uses special info type records to report the old and
-        * new parent+name.  Reporting only old and new parent id is less
-        * useful and was not implemented.
+                * FAN_RENAME uses special info type records to report the old
+                * and new parent+name.  Reporting only old and new parent id is
+                * less useful and was not implemented.
                 */
                if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
                        return -EINVAL;

-       /* Pre-content events are not currently generated for directories. */
+               /*
+                * Pre-content events are not currently generated for
+                * directories.
+                */
                if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
                        return -EINVAL;
+       }

        if (mark_cmd == FAN_MARK_FLUSH) {
                if (mark_type == FAN_MARK_MOUNT)
