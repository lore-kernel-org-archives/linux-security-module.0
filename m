Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FF33DEFA
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584561; cv=pass; b=mxsU8N5P2QjWJ5nayzYTOmrFWRZpIaFdxejoNZXBjXEGtC8/MpeHeuhpiN1WBb+e5q9tAsRRgior5giKPOhrOXGdBClU6fMb33fT5CXwdDDtW+gzZ6sW4pSBQssoCQecDJDR1c/Mo8m11VW9nJg6Q/kjWwWsYCOcsb6DQqMcaJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584561; c=relaxed/simple;
	bh=aOLVDIR4WnlUw1nvqXwQwf234Bh2W6bojDklxd8Gees=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=covuS2DLgYj1SHC0C2sYta5H03v/Ho09N6aNT8bxmR2Do9J8s15LJptAVxJvLdT6iEBkUFpX0B9kR6k4dO0YKPIbV7+OuGcuyjrMIguUL0j/CV9D0mmiIThsurxef8KGExBzXroAg+/x8mFXbENBq4D04Kh0EhfN/uax2KSgMRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JABONran; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JABONran"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371119eacso18002445e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 02:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584558; cv=none;
        d=google.com; s=arc-20240605;
        b=e/NmkZm2XfVRR6dppzmJByhLNJb8MMox39Hb4FbfffTfXW/T4cXiIHvOafeYWmtIgV
         tFmkgZjhdQs/vyLFsEsOUQBJwVbkzoY5K944+QyS8zRax3nUWf0GWlmcvsVc4D97SRVY
         wb5TXjkmY8rBouBHAo1HAwxXal31qg81Tveaszg1pEsdpgblTJ430C+kviT1Ik5mRomq
         iOFh0Ja2gDvPbq96nspFueo9M+p1JIh8P8ApTQ6sMR3A0gO6sDHAeB9/cmANm7LmXY6n
         kDSWQBLILI/vgOGiYw8xezGwoC29GiOtjJPO+B5r+g1O/tb9cm33JGSndx2FBiQIZXC2
         nHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        fh=9osuJ03oiZ31OwNRIjpWv7FZo3zUvRfouZ8Y2y0bq6E=;
        b=Q4ozYjcIyN19xZ/weL2hu8UAAEGt7zAGqpGccpgdBNIIPk8eJN6wF/orz2ynXErHX1
         nyIYiX84w2Ak3zXI4Cc6sOV8mD3TQwMGErEGIT0RuXUaId1kWN3WYSnfrZ/OLF+x+G4Z
         7enhw1g9tf+BSBcziz3jY73qOMgbwjkVQe9+plPXRyEvjoQWhX6su2Choa1NhHIUVm1/
         EkyJdFNVHibaxCrKW21XD1Qi+MHuwYySZWZVpsx+73scVw4KgPdfqgQ95AyklkfVKgXE
         ChI8qK4jhhc+SaeHsvzkuFynhHjYX2Y6J83z9W3A3KCa862oL+Ga3liI02rAAKFlL76F
         0LoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584558; x=1772189358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=JABONranC/t/ZRWaTeXGCdbAg3MlyNGEm32nb8g+0L+PjkN0k7v4kud2f/Lc8HtI9p
         RSJ70uRPi9eRvWSiQdR4rSEaIEyNlubpm35GfQ3YOcWC3G9WcVSK61xAwUJAmv+fEQjH
         U0VDLzRhvDs3mprDIFVy3TKWENLnYZA8lvak3zCs19Vc7dc+4ymdsOOcoNXANG+9O4wA
         yAElmODqtzgqw7FDaasHWfeg3jDiHmL7dRWAknBHeykcq12ka7XVCsyOk7kCewg+AQ13
         iGKyafSskeM/uBbKXgMnW0Dq60qRd6tC6hK6mVrNBSjRBZQXO7HJmMLT1etJbZnXuKpV
         q+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584558; x=1772189358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=UgVApJkYLQMPfI946bNqHUwyjO2FlqLe1KD43X9fsf7x0VYBcwdbUJyQrV/bJUCkxl
         2vio3j8+DfPXNcOAgpuv2qjw8Qc+oMH/jV5Nl/cXkMBmIc/eH0snoRocfLduTLe2o4zg
         L6U1kecmR//2m7adoSTkJddrMZxiYgbK43SimTN1Ox31Lof/wE3FzXlq0ZFyVj4XJ+ZX
         4nT2aR4hfb34p/MLN4MEy02vGOlYmO5++rLIKmzUPAygF3KCSbKmaToD1cdTTus/LwCc
         TWSv/5lb8bonVx6niqA+rw6fu6DMWaVIj313pZzlOzkx0l6ts6Wad66Zqw0ErkIi4mr4
         1+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Pf8rwc7cZYkeT6QG9rc7npdibvIjFRvzT+jDXQFoOUCapxgVLKum7AKailu3QnfpDQOOCbStPOrgDJuX4MN/TnOqQy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxbSsUqgzBpyK8frTW0JhBhqXYkSwW98Le2QUmNOMasahtXgt
	kN72rv3V7U8rU5rmZNdEc3fx8fAxvWCdzVBh7U8ntxkAGYZciXYD6fr+yH2vmUcE4pSkCC805LV
	uWZmR5Iz5lwMXO9MSZXIdqSDuM2tS21OAXrIRpxlw
X-Gm-Gg: AZuq6aKN3VW2SmJppzypDcNM01M/2zm4+3Vf1iTO9DNpo3G+VThk+fhxAEUYZClGvfR
	dlqGd6ABo8EnUyUP/KM6/tX9QvXhumIXFI6pyMM3A5Hvzp0iX97HncqYuar76cgs/EGMdwJVWcl
	qkMuYeEQY9I14kYcRYw5brOaoYcpToA1JaK2xuaNod52guyPxsa/0tnOn83gGxVTECQp6GaDUBx
	yHoKTAL2FeIa3cksJXjuUbWs4m59tOeVF4ODkUbti6+uiiyv5/NG9VJpLbZJ9hmUFQGDw786diB
	Cc6oPC1jVmHZhxZcvJJsOXSkatfct1B43rFdbA==
X-Received: by 2002:a05:600c:5289:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48398b0990dmr130223325e9.12.1771584557648; Fri, 20 Feb 2026
 02:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:06 +0100
X-Gm-Features: AaiRm51MAhLW1OtRkAHOYwRwshfGarw67yqaE2vYRvgLvB2RCqsl8u_ReojFPGo
Message-ID: <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
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
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/page.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 4591b7b01c3d2..803f3e3d76b22 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
>
> +    /// Create a `&Page` from a raw `struct page` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // SAFETY: By function safety requirements, ptr is not null and =
is
> +        // valid for use as a reference.
> +        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }

If you're going to do a pointer cast, then keep it simple and just do
&*ptr.cast().

Alice
