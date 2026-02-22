Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26425DB0D
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769984; cv=pass; b=W47RMpJvE+tsiTGNFTOkIDlCfHkoaxy0ileNkzOqdeLhuC7F6VZfUKLChqXjh8UsXSaInveIDM02rEwHFX/l+jRgipsumYi5Po+7f7IXsFV5bgVLY8axiyhwMAFW0GOO8rSzIJjA8CwuK3lrA2EO4MKa7o1XyjGjWX7QJNwGICw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769984; c=relaxed/simple;
	bh=ln+l2+kKkFDBmSOGuUA2y37XlX40B6GZOr01SweZv58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXEBE8Kau6im+3nMUDaQHDgjRwagJFWa35f/u2WnNI/ThjcQ5/RWpUT4Z6jkqixeBWGSNEXYmGWKkSnogov4Tv9arXCeYCapOq+143TuTc+ROkOYvVXxPtM1u1FCp+VQTbE8fNbgoJ28rO9PD7V3HVe2ub6PuwKrb9Vv/jKi4PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nx8KjheQ; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nx8KjheQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1820206b3a.0
        for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 06:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771769982; cv=none;
        d=google.com; s=arc-20240605;
        b=Oa1WGgpdJjySjFc023eMA6AOhMzUW2hRZ4boCBhxM/kNLtmTtdgbTWnkCTyT6F7/bm
         FnHebkqzGIyh9Q8vkknp7KpPGAynpZRROKhQqoJmtIcpK5E8R/P1DrIHkjH4v/3iIga6
         mwOg5kbtsetO/72sHzUbyD9VCML7dJBuxZ+TSqHl3gqg7FGDOkHLlKJp013tKH89PQw1
         bnPY/UdG236XFBugCyuavsw6IKKxRQQwWxTEtfSH6noajW6ChEDpngDqmMqzsQh0LhPE
         5KXbA3+jawP6ZjXMQgCiEvdz+NOAteWbIDm1Ghw/8Ch5dMDd3/WVorzsCpmj9bCp3x/V
         Hpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        fh=cIpNWja9Hiwq2P55LL9h4lFOEXSaOr9NOItvZXitpEc=;
        b=JZs0+OgJVWvwklZscIfytJNG9UIyNu6JVyFbKq8KPhmJFWCjzX2lP5XDW0l5NNcUHT
         gl8CGUzkklMewhZarBjJVDuTGjRTHT7YvrqIsHKyLqavuMaeUEqg7rXY5yHLD87QzRuk
         kComJjZGQGo3RXnW8r520ZKY+XEgMhouBZkUdb/PJm/b0GoQpCCnGsPtyzWL0QhZ0bMI
         TMUaZCSEZOHmTilF6jeDMLtYkHiJbLD85wUz0FRx3IIznWtaio1aHa+/stBeSse8+NSp
         lh4ZZ+Osr3vkmkGKz42US6cB1L5EKPy3OS/LnVH81lwCIDuDlUvfIcYLgSXT3sH8Y2CV
         /o3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771769982; x=1772374782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=Nx8KjheQqYFoKeSsWjSjDkljl7DeLxDbijMH0TCbUekr4yIocKBCavivrkgn95uFed
         XuSYjq8Pcd+5CapXKZGXMujHyPS8CM2XMsK1VFq/NEU9BlgNRr0AX30vP4yE32dv7A5Y
         Hbv2Gia3NHVN7Dbg7SLniPYX1r0AX1nZqO/QynXl0UmultKmwbPnGnBn1UVWQBCgarfe
         8XAXggaIceD/wiAeYgSlFc6fVQeagqwn9JRq9mELPGKgvBWXjAAEHwqVz4J9E4ZYYqaN
         3M/u7GK2xgYQYx/5yhpHJ3oZznFZe7PrOTMXiMph7pHCPiT63E99Qjf7j/+JE40HxrtR
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769982; x=1772374782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=XuOBmyk90adbHrh/g2EQLjDwdpdOu7WncdcB25BzOcgEpX2BZFAZNBQAvn6Pe7DIzX
         1aAjNzYw53OKVk0c8yKKJX3kSYtNdVPF9eeK8r6Z873OzXwnoiFssXKiqzqV2pVGOad4
         n6UwKYOB/z2ktUmNcCtX3iPukmlpzZkZPK0Y5J6+fu/lq1CyZHHIEWSnqNLLkPqg7NJM
         WIzS1MtyGWHNM5iVq+Oda8MFeEeMBxZF12gtjvOJcbzwB7Lw/rfN59iAfcbs7zaH44AA
         9PDyd2PofNrWDkblg7p1zhC32jxY20zSxEDBF0XrQOa1DRJBQ3nUq4qQ01H3HeeRGsEB
         BFIw==
X-Forwarded-Encrypted: i=1; AJvYcCXIQBu33EAmKXZkJN2PjfcLcz8phS0eli09SKo66wzDuujIUk7E8Hp7RHRqKs9t9vVRimd2Zy+spKv09bCg77r3rfUWc60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXEHH38wckqYJ0xk/PwiaAR6RbUbzKbpclzTB/mbH+LqzLJm/
	40eqVIuRZBQEVS3V+vqa6KefseV+8jvxZwm4CxIuJJRXxZdWf73MrpfQ6AEbnx4pO0+ZhXz9aCS
	UwdCnmwt2j2wfqY9C2Ox2dgdK+Zu3npEN0m/ZPZN3
X-Gm-Gg: AZuq6aKyABdhQfeyK1FWdcpwHom4GXuaQOc2k8DOdCmewUYDLBEWlizzF/uK0NOFfcN
	hvV2Vmsf+yCrayJjgvJM//2guxXoeqcOgvxBS+/BJ6+jMCHWtFMLXOpxGu9OteXb7Z+UQZVIg9X
	dIhrxYKLkpBvfgRMtOAu3wofVxwyUbxoF4X0MHbW9fYCz6GuhfJuT3gExKwtOkwQL2dxv70oLpH
	tsLfXJ+0PsDhhhaeObZJaQfacUkeWKFxc3qAHLTDPD9RMcpTq3mKVAX+OW54zQnaWnuk+tzsFcP
	V3vdPI8=
X-Received: by 2002:a05:6a21:6003:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39545ed5054mr4712151637.27.1771769982592; Sun, 22 Feb 2026
 06:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com> <177171292163.8396.10671162503209732019@noble.neil.brown.name>
In-Reply-To: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 09:19:30 -0500
X-Gm-Features: AaiRm50aSxTeiNBHciBrrBXQYNf54mJgxuioR2fz7pTB6PQcKrI6Gq_TY-UauFU
Message-ID: <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 5:28=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
> On Sat, 21 Feb 2026, Paul Moore wrote:
> > On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Instead of explicitly locking the parent and performing a lookup in
> > > selinux, use simple_start_creating(), and then use
> > > simple_done_creating() to unlock.
> > >
> > > This extends the region that the directory is locked for, and also
> > > performs a lookup.
> > > The lock extension is of no real consequence.
> > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > d_make_persistent() is called the dentry will already be hashed.
> > > d_make_persistent() handles this case.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > Unless I'm missing something, there is no reason why I couldn't take
> > just this patch into the SELinux tree once the merge window closes,
> > yes?
>
> Yes - but ...
>
> Once this series lands (hopefully soon - I will resend after -rc1 is
> out) I have another batch which depends on the new start_creating etc
> API being used everywhere ...

Okay, thanks for letting me know.  I was curious about something like
that based on the cover letter, but the timing wasn't clear.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
