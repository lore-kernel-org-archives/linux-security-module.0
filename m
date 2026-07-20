Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D443991E
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572303; cv=pass; b=QL5YbO17BgDU4/5PPbpNPo3pVAEgsWGFQ8/goV4ueC6IFYXIg5fqh2Sk/YDHaNRzuwwwTsY8w4dKPAb+psK1W3SgAhCAn8UmlAlHXY9KZq/O5La3Vuyc4zCTCga1XFeann2EZUxuVGMX7RA7uSRbcsyuB28Cm8crohxvzV9PJeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572303; c=relaxed/simple;
	bh=LC7hykOo7NcQDgbbnYkuyatZKfLvtqyYnzCxrtoDhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOjfUzu+HMi8uLJuO7hxvX8cTnXt4WaOdhtYMwpqiPy+LUIwum3MqwQVRWKOQbVRDMRejrnlH34Lz8xF8YRbNDemvveguWySCoK8p8jnRSldRwjosiVmz//gYAbhSA8DL18iYMbtvJ4zU9+NVbdhcz/Y3avbGtjuh8V/ODDxbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4oDpAV; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4oDpAV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caed617615so115716195ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784572301; cv=none;
        d=google.com; s=arc-20260327;
        b=SZdMIRq3y+C91vAzMghNco7M8Pt43kURtnPc6sJO85aaXp3iqdrFDnfgDYUVjcTAjG
         ebyjHbR5s3+ZShhPNFVO/f+3Dh/IVXmhYUCq09Lro2kxDQJq0O+1DBfWQvkBZoRPpgkj
         cfH+y8xKxZQVD0palSYXQTgSDLLzD0qOdSPkQRB4yOMFB3uCu2wHbFgkiskx9FD8rZpY
         kRzsO3fkW9sBuZvwZMKMDzwJZqi4bto4G6h6n8titsmgX8ZcYpaQeotonF/e+5hAwV+V
         9HDiUU6BtNEDQ1Bo+s0RDgaAy+mWR5ymTJja5EhDj9NIcHrGx170wAIlR9YnEZLgDk3Q
         hkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        fh=2Qj4hgCL5sJZ1VpI64/FoLq7g4GLGs+ZphBjLqr4634=;
        b=WDAEd1yH2W/wqEZiyA3km3XM8OgCvHWXkAqt5QN1cbvznzju9d7Cx6g+SHxOEsceZK
         RpQMQIqxXxSWjNOU32r9Y64HN+IYWGdRhbd0hSvBf43CNBMxqtLfBsN581Ugsvsa87+b
         afJtj26fjzz7CEMmxNID1+pbeQCo0Q/ygp331nqAyl4Lq0dUy6c+fHacqYcWB3DDyL0r
         kLT/mGZ5F5Xzq7FdmbiqNKinShFcIJEL7U538D+qnz7DaQgJqoLL0FGx1WpHKz0AnDCs
         s75wcWmmdJp7qXAADmmwhSN0ByyEi4jg43CzZwB9CK+o129Y31giOiDsWRWznfzZjLUd
         QF/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572301; x=1785177101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=SF4oDpAVjRYKdSsd1An806F+kBH3rf003d0u/ZUMNNm7Z3eZ/kHMlpnc10wsos72ad
         oUVSW/oegIFYOPHJjIelk0S79rBUhoWc1IxaZn/GFnBqExrzXoMic3eoXfLINQQIZ2qz
         tA9QBh17mfw2HmoEip2+j2tXcSavY9xNk+6qFYmUxbEBLFOg+1y78i/MUQpeItTjTJWm
         BBeiwakKjw0Otg45hxTUrmXoCmRGjkLygItlPBW01aC3soRn+U1ru7O6dzq3Xij6aWuW
         HWrIU51Yw4aQ7Wp9fC+8Ioy3i7m2/hJl55Afq+HIz1ohnbQvRwBMYwsoWHSQ62lpQjgx
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572301; x=1785177101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=lhQcfXjy1FgPKIdJDA30sdIR3BC0iD7WZPVp/9CU2GDbwbaommTeGArADg14JNKPyj
         uqL6r4kyFVRjCGlL5DmxWvwF0ZlbQxFNZ4o4xXDCtQtIQTyK3VRbftUvKTC1DO0FX+4f
         7v9CJFd69bxuGkOjd3Pve5AvUbk8HnJx8R3AoPvdhhFeaBkBT4tFUvv3iUb5tZ6+SHY3
         ENXUMZ67MLAmg1TXXoCAgrtC2uj4bJ8kflKST9kRgJ7fpAoG6T192yQ/XTQloQ31lVQE
         pAsh6TW/s2YyXft+dqlBqhrtZW0/r+HpsWHMozSyqUZ5lC77S/ElqSKq81uWkurGFawY
         lAFA==
X-Forwarded-Encrypted: i=1; AHgh+RpvyJ9XMZF7tAxVWcbqnGFMbknngKgyAm3MhqhSlMButaqXkZEM+of/ZJlWkASFhLARjLVgszcUwyXKa8N4nwlKhPCl2EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXSsFA1FbPo0K7wFucC+81twu2GBtvRTHzZmzig7kBib8qvJj
	al8jL7Kt/ABFfa3KXeQlWGhigYbbKFECsEAEe9xmX8XFv5FgVaHxUQtBTZN/aBXLFDvytQicnFm
	Fx/NygrNHTpH9M8dbt0/O9Iwg4kAXIrw=
X-Gm-Gg: AR+sD1295ZteqEv2DAL1qFg2i+EGnFvMx2tm8XkvDLJ6FF69h05YQ9KOnNpcTUzD1WY
	DeMIwkqA48Rn+P0mwxnSyl+n14oZboijfaJ2RraraSFd7MG//U53Mca6mkVNkA3YvvxIj8AdsFA
	65ugN09k9MbsukwEU4T+JdTGN62YX9rHiogw9oRAuwNulYd+/PsgeG6fFeCw3fuvkJRFQ8XGDQC
	oOxtOTbv2T6nfCPNMiVrb0SFBPC5Y2W0na10oBt0dgEGbql7Zc2fkNwKbZqaTT6qLF77gR6B70e
	e9zLOy8u76+ZqYg3Ef5zZmSE++Y=
X-Received: by 2002:a17:902:fc4b:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2cf349b590bmr166172285ad.22.1784572301567; Mon, 20 Jul 2026
 11:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com> <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
In-Reply-To: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:31:28 -0400
X-Gm-Features: AUfX_mwvFwr-TgBt_1bjRhuE8WukQ5CZki_9yiHUuJNp8q_cbJ7bjwASItGBHzY
Message-ID: <CAEXv5_hc9x9XJZr646efGe=HD5Y90FtB1m_xi--0wWuaD18EKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> >> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>
> >>>
> >>> I'm sorry David, now that I'm seeing this function again, especially
> >>> with the LSM specific bits extracted into a LSM function, this absolu=
tely
> >>> belongs somewhere under security/.  It's only callable from within a
> >>> BPF LSM callback and all it does outside of some BPF pointer boilerpl=
ate
> >>> is call right back into a LSM helper function.
> >>>
> >>> If the BPF maintainers aren't willing to accept that, then we will al=
l
> >>> need to find another way.
> >>>
> >>
> >> Where this code lands doesn't matter to me, so I'll stay out of the
> >> decision of where it lives.
> >>
> >> If this kfunc goes to security/, would we also want to move eg
> >> bpf_set_dentry_xattr similarly?
> >>
> >> I'll roll v6 of this series meanwhile and we'll see what the BPF
> >> maintainers say.
> >
> > I don't think there was any preference expressed from the BPF side. Log=
ically,
> > one cannot be faulted for adding a kfunc to set the xattr for inode in =
the same
> > file where similar kfuncs to set xattr on other FS objects / entities e=
xist.
> >
> > The question about bpf_set_dentry_xattr is thus valid.
> >
> > Anyway, I will leave it to Paul and Christian to decide between themsel=
ves where
> > it makes most sense for this one to live.
>
> Also, perhaps it makes sense to use set/get naming for this one too, to k=
eep it
> consistent with other ones?

I considered that, but we're only allowing one to initialize the xattr
on the inode here. Once it's been initialized, one uses
bpf_dentry_set_xattr.
