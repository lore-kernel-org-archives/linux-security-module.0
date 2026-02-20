Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D933DEFA
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584612; cv=pass; b=arISigS3XoUgKlbQuTW2hRA4+7/0XlyS9rKqJVD5MxVHLVt6C/8QvptubG4JbU96AOGRwhtwtTKAFyFTBdCALq3db/Oq2XFShR2DRRgCEEu7VJwEFW/tbCC0ZRq+JVNC8HXV0vQlpTWjD0HCuAvuuIuaBvNdAGi0awtOx0Shfuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584612; c=relaxed/simple;
	bh=oIngJ6S5SUKbvESTbw5vt2bQmTdKhr5N3+wDe58Yw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv6Wc9iobLaehqcpwFiWoOgtiJ0c8tucRu01VibFIywXBEOP1RLfcVi+8OTYwThMeQ6TDy9sRzmFA07qgKnO0b59+tTW6sYZqnsrg9tZh5Q8f51jQkCNJf7AlhC+9qZi5XOw1EOxq8F/9K7ebG7+FV6+ThvgQc0MmnUEOjsUj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw5VX7pE; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw5VX7pE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362c635319so1812800f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 02:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584610; cv=none;
        d=google.com; s=arc-20240605;
        b=i4J/onK1YnX5ONPDEWxFVSXQ00NqVcEd84tcmMrxdPSSV+VMwi00A+HpMe+qjd5tjM
         m3VbdRhBdRJDt4N5Iy4vwlWWOZz+Q7FLMJa5ZZQgUVYqoVXr9X9fFJfPSIqh+N7/OFGz
         hjmXthpa7xPutKfCVc+NfyFB963KO+r/xdi/8B3vV8U5JrgjZl2/XrkumKYUqhbdJ1fL
         rJGN3+ldZHc08DmeVInNccbr+zFj/Ek+MF36A9Hy54+Zwg501ZUEHngJ7/VaLju7+5Fa
         zze2L7bjtZttdytJ3N14cSQg6M6K9PmJhyyJNhYSIS+3AeWPjxspY7CkoaHjoHrigyaL
         GSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        fh=gM0RioIXR2SxzL+O4sed3XF2x7bk8VqNsnci4Dd/H/0=;
        b=f+Kh0E/cwt1TGlHj4UcJmC0tVau/Uh4WYywCyMMn5TLFDOz07wqIjrZPouIEBfvUNk
         7HnQ5Bynrh4cYITC+xroVuO0WpNyb+fsiOF0dyQxLoC687YeQ5OWGE6oLhJsWKd2L7vS
         nbPTCtM+dmPUvwh6M0upClxazhQyPnPgRzNJwVzt7KzHSga3vK2EjOe2KSyyCL0DB4Z7
         r/coycOO3eGdN3RpPyaHEP8SEgOu2XO8VQWv0d3uYGGpTFRMuHmT1ivc54AR6gpVJNMO
         DaPAw6YuD8T0TMDZWN87MzXW7X4GiZwApkyPpO9pZFrfPdEVxkxeuaN0k372rEA+xZMB
         j65A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584609; x=1772189409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=Yw5VX7pEPoJ07tsHwpMawPnFDCOeML1UTczylvi6vDnvLR2lMcFPsCceidZjis8UxC
         BAbrl2E0tEmKWqk3oaoX5lwhugK2JWB7w2OJjWdMIYyrSGW3s8aCs4pFQz/dpxKIZVRg
         qC8n/ReAEQaZIeA2dPtE9fVtrdFbXy58czdpdEtci+SOzMAOzH2OUtDP1LaZmnM5RwAl
         YPS9Oo1UKkDV3eAQTRtxZdcDd5PAvPderl0TMky21ELTvS7wkRWfXHix76fSeudRPiLX
         LbBZU0bVjHAII2I2QnxUONMUCt4kjJZgl8CPHpCzGP9ky3278yHP3U7DBx0/bXSVTPB1
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584609; x=1772189409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=NtTeYLpxghgCHlNF5omKqTwLvSBLKlhs8iuDFqqgIK/LyqsmnqgMs2ec39yWXM32Cu
         4/U4e4R83Po8qj6qbMzARGROajBpxEWzczEAdKSdKVnTa72BjXgKgDQvWMBT/Z1iHGSe
         DtiGblVY8f+TmAynRe87tyBELcFM8kDf9KWAWr6IJt5kfH+v5YPr/NN8jo85UwvgIsaj
         80UPri3nvucUD5bokjUcRB+9ph+Ue4Mx0mGVS+ESrd69vE0YR1OLktEomkPAPDnk5JlS
         d5hxdeGmNGgt7nVwJMcjhhJgVoyyEbHsVamCZtwR8P7c8m0GVwJVo/N5fvSmgOupzUlC
         5SYA==
X-Forwarded-Encrypted: i=1; AJvYcCV87hCg3ZPqhw82oM8DdaX1jWH36K5vuFuP3coWteaJEgx6yWADbJFx51L6sBxjVuCcpP+37hGbRCDFcbtT9KKZyRGQp0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDeo9D9p/B/ZbwhIIELrmALbadoMMH+JPJRU/zXaoMtPaIwly
	hfiHSq+p4MdBJ324eMM38WSEuT5PYw5R/xav93P04FsXFvKhntwNyZJpf1F3AOvpkVK65V9vF4U
	MPL4/NLCGKEUK5L11OjJMC9YYJkTVM8cQ1lFWISne
X-Gm-Gg: AZuq6aL2VD5jyOzHLBbzTdtXLI7tJQV32HrvlE1491vYNBaada2l9NzSFNTZI+/RBEC
	PD18Am6wwcC93+9ivgPCk5/YBf2OLl2H9ktYnEInE/vacH2Obl7x3kdSSkhWRIKz+0wokGuMh2m
	WqVSOM4axLy9/7LOQFSyHAogUGh0G+dsrk9i1NpptDAESVbDz0thhbemobyCrVfGmFaY6LkzunN
	UN2wB9/k/9fSGgN0G6r71159KZJRWlRWRP5VfXpuQ3TNbkljWP8oAtlXKJ9n9I9Iz8+8eYexHpO
	hi+lkTmZgAGanb4u3GP0YGhktk4iYzMrS0TahA==
X-Received: by 2002:a05:6000:2409:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-43958e00ce5mr15101201f8f.18.1771584608836; Fri, 20 Feb 2026
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:57 +0100
X-Gm-Features: AaiRm525n9TXR47KvplRQPUHuuUwgU5iN4_ng3kUHWK8LN9TrQcHulfhA1IhjZ4
Message-ID: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 61caddfd89619..efe16a7fdfa5d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// # Examples
>      ///
>      /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>      ///

Either keep the imports visible or delete this empty line. And either
way, it doesn't really fit in this commit.

>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///
>
> --
> 2.51.2
>
>
