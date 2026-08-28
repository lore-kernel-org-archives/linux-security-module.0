Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68994369236
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922318; cv=pass; b=kjtAqCBO+zmLeSNSEQmdbP/f+8ZVzYRk1FBCMHPcfcx+b5ksRsAFaK2/kHUQ0SVqJ93aVd09eFhuA4cdOsEzFTohCxvBySKvfqosw8qwcqnLVouQ3n/rYBInKdlquN67+MHUoPoh8Ih7ZBuQU6jGxPaVPRVPF54R9VoKFla7urc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922318; c=relaxed/simple;
	bh=pajnVni3fs8345lKRDE3FBdUZGFKUMVeC0hP96aTX6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMyKimPduGceG45ba8uV65NcYCgtRynaRiK/6fNxjiNtaP1juUWzqxYajqe6Su4zV2n5fGQcsA/16PUBVnWhb5yuA0N0ltXqgY+s4Yo3XHiz0NwgZ/JSMV7ircD+E0QFZ/ONJU3lu7HYilsE5Okh1cjvNPVeYHShYL6XfwQt4eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9xMtPrb; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9xMtPrb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso114085ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 06:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922317; cv=none;
        d=google.com; s=arc-20260327;
        b=M5zvrsyYwZSN/nA1u7PmWz5TZhd/5WjlUz50UlsLd9Vym4vUtB6jQaD6Mr/Miouv7O
         urPckBeOGXRXz7MsZPw5LKkcc91bmKlhqnDGowf21z43JnHAHVJcg6u9erJGEt2FYe9v
         W3/EojLbUf9z/+FxaixhJVEoakhAgIbQ78plebok1ydAsMzAsw+Ciaq909KQrbKOEgb7
         kdvxoF+/uxEnwPDY/sctXcddH6dJx1ROkH8kIQdJ7YAaCwhtxQJrf5YYNprdW0kSPhu7
         SmMy85RAsKh+TGFAVUNtGm5GMQHmaqc0XvJ0aFRx+65mphuXZ6qXqL78Ed5tK2To4vKg
         7tZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        fh=GHIkRN6ADbgNswebO/aJbUbhzP5ZxsuXmydgOVLbOKU=;
        b=UZV3HZoU3AUHfTc94oHInwQqcIv5fbClvO6tGSLQZuVIAcRHL00rvb/zSGVWSoM0Hz
         hLsxA8MuNXpEfJQgPZ5IMiJHkEUtB91nXL5MSAQT3+AAxtn7DOYAV9P236Ibd8s+OMcX
         BVvjR+aoXs5/iEbh8MKUaqRLGphOiprOAbopcC0iExAiXBPO8sNT0EoUwtf0cMKgICXA
         U4JdgM4s1fi1rh/C+wwTyeURd7AhhmzdFxHV+lM9nwdv+J3QBBCZyEWS9yl4zLFeMSzi
         Q1tHd7dhcI9KLTgqjXi0jmpIq9q6wax/AX4Twfa4mNaapIdcqzNiKec9LqqGAnUBK40w
         Ju1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787922317; x=1788527117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=s9xMtPrbI2x8d4KzdhJwQ75f7SuKGJFJduQsbl43byIuGIM+LumG6m7kK017wSxnsj
         5ephCSET2uQRpKk2fTa/VeI4zaQRGe+mqr4BJ9N587Em3ZPJFVxHuxi+kstCvGWO7ZI1
         Umk9Sh7dMT3DhbdU6yCbJTnCNOFlV/HvSdzxIhOB0JRJoOXIS1GfzZiTcNhepGp4FReT
         uygpTFo3O2Zm28B3M6FxJho8mLGv6iMg2nbAi/bfG8jXRQqTYuqv1BWavat6gYrgmKwf
         kHoxOrGmo2vFPk82zKAal7NBlRBC3DRJwhRAw0O/QJgs7vJprFtoso5TBzZcexaMFlfb
         WxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922317; x=1788527117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyY15gZ/uyotBCsU5YViQYJjvIkD9znAZ6y7wL3wuFw=;
        b=Dy0as+xSLdC7F1z03Po9cHKODm5dcXkRj5IuOholdBfww5cZQYsz0yJZ4EhsywBB/9
         3QwF2R5Wm90crQaUZoHjyCBztEh3JvG0u78LXKlIOmH37zo6+dhtUVsYYNdKHlnLzFO1
         VVZ59x91kvC3XTcbv8IdEtjZbKryrC3dMnpIu3Hk7zVo6Cxn8mwS8IrHBm7js8I/cwJ+
         iRnA98X0f9BHXon2g9p9ZoaLPySpqxwOa06mTKbPCILnqEhQ8mDflRlRiRhmxJL1W62d
         +AjbXhLGEMjBG4Frh+ZL8hcinn4Hz1fGI/wjcmyvVtqWmc2KwZN+YES1yzkdXw4Pd7Bs
         cxcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQE/Dzxon0B5hX1giEqRKUdK41XOzDzUIFvFkAnfVl4gbMVK1fFJk2QnlylcMbNTBAZzV35pCbY8ribI/oErbCaK54efQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lmchkVjKj98/OQDXouckAA4fOtWTXMTvJirk5rguFwSaYKFDPI
	cThb3DIbAr+cmPOp6y67dNzHshFq26SwOYztvkGbGsZt5zq7FFsswMvixmSJts3v3Eb5zkw9Qjl
	J6UggLmgpJQBEvjwvIsQ97sPktYNNncGAY3gQv22e
X-Gm-Gg: AR+sD12krZCpwGMFyLa4lkD8XvDx3fDdfwrL1f7lQcwdWwJDQ6wBvoc8mV+TMHzw2jJ
	hx80muQBxNy6qNagUhCVrEoZJDyPxxTX8SkwE4MJyrJPYxo9azNp2StEjDfdO3pIA+7ZQsZEgkG
	i6Obmu6Y5hKdyXzCyz4Vd5b0z/14vPpD5IjI0/s+hHchzbPpNE/bsh8mHMt3HIBEGRY6SegIBJ2
	JIQzOhyxvsC4ooicsDU6h9lVOtqxUxb2Ws5QPtWPiiwunqUrA4LH6fxcyjuOZuzfr3v2z8/r+/s
	rV3RauV7u36Xlu7XTdwqnIXjftvYEiXMgt8CIjUDQE9z6HWLq07gP3DpZS6ikt76jFQCE22rVqn
	4j4H7mL3y/Y+fvOS7xI9GNeZ0/L4t9rA=
X-Received: by 2002:a17:903:987:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d75482c43emr5737145ad.3.1787922316046; Fri, 28 Aug 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com> <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
In-Reply-To: <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:04:38 +0200
X-Gm-Features: AcwNN1VyfOvZNu7ELf4xzHHJ3BQoTm58QSMty2PAZc7oNVjQteiUlR74XB89qaw
Message-ID: <CAG48ez1NsUqpZmr66RaeFXMicpZT2FjMfwqTJwcQva50XN6cGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> I realize not all of the SELinux hook callbacks use proper kdoc comments,
> but I'm trying to fix that.  If you could make this a kdoc function heade=
r
> comment I would appreciate it.

Ack, will do.
