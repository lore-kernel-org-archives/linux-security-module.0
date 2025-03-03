Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA851F4166;
	Mon,  3 Mar 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017124; cv=none; b=nWMkYjy1LXNSbf///UbNfxxzynTwTx52UXH+yLV4nttl8xzIAkHpgY5UCPDxqUHXJrXXpzQBHDEdHO0ibYYNZ8aFq2BJgNRQ6aN49Z+bp1Kfznipqmvpq3af8STSeyFWc9G3197KqtbkOq3tyjiVQ/6YfyY6tgsbpxW7Hk5r1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017124; c=relaxed/simple;
	bh=TXkBDRK/q9ay323COZ7tvWye1rqrIFytXJeAG1Pa3Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3OHeg2XkJX12AbOs+ghgoKuZfAH6ZR/rKOYLXo9YPOYE1Py+94/Q3FlVO2M63kH0xozpwlOOLk+iDtNbNwRjEQlHE6DGQwIKQj3BpNn2AbVa68fGtSc8VA4XLLFNicH2FyKVSAN7rtyW4gqQBEykA/D21t7K9SDER0aEC201Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/bPQOeJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/bPQOeJ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e892e0eb74so37681396d6.3;
        Mon, 03 Mar 2025 07:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017122; x=1741621922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgODL2LlqaxeX8CwqEhnXUZN7OCM3I1jPbEdCi7RTzA=;
        b=B/bPQOeJoBs9BossLO1l7tsJ1olgeqvdajCHy8RicTZHaAFG4EQaasYFN1r4eSEaUa
         F/YaMwxrTHjp0boCEk60vSoKPx7Sgu2Nlz8AH5n7kB/WvOPKIity4umAiVXAQGxNlVfy
         +upaaPfjbFAx/+cNQuemUYEMOHXBikScDtQRrWYGEunOzews7oL17Yb+zPf6p+m1y20s
         b/6sD/fcYBFTOZVJdzfJ2kvQrWFAXCDpCx/SUghdXITlXOP4TEe7vCgmDAGI8VR/RYpP
         NrvuGRXqJAr+x5i/gO4EB4MqGQJZtzpK02N4B+vyvBz2LW8WA1Jw+LM1TL/0MQaS9H49
         v/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017122; x=1741621922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgODL2LlqaxeX8CwqEhnXUZN7OCM3I1jPbEdCi7RTzA=;
        b=dNMfB6L/0TdNaA1EfzQeAIdVXkz065f5vww7aJetUAUkMnbw1ByFl/lRR8Zg+J9FIg
         8qb0LbGz1T3riUX2vsrbmcFtRezZmp9k4mT80ETM3BOtb7AYM6zZneSubAYvebZ6joBr
         uAhmwXhwbfikhnX2rP4rAaWRmdPKr8vixxD9rzzElbs5vTH37FVq3Y6zqr3f/Zy+pDYZ
         fUAW9lydVYNLp0oeV/TTezX6EGIim1KKL3MWsbinFwJJ529V9YrnUJz8kAKLq9TxBkUv
         hYq/0dvp4Yt0Du4+OxFYdJINUQGxiK0vZanNZjWj4sXzlgbYO0PeqnmJXa3BDaX5Wp5s
         2oVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxhyb5OjbXtQUCWXTPaPqQv4iLEnZe2znbEpxx4YLAEI4NmbIURfhZKJwPnHud5bnz058dtiQmUkSVb28=@vger.kernel.org, AJvYcCXM2PYGdtnAHbwnwz1ykBm7tE6Brq3gzgxkoeT18vSSAYd5gVJftcWWJIvuyFFNEgJ28nJQHBv73U7B7cmCjXg=@vger.kernel.org, AJvYcCXjCIpEsU/O8i9FYkg7NZdUnMifwnAOI0HsKv22sd0Ba7zEQ5mAJN2fEcW5RdPO416nO5Siz8B0umOyadk9DK23VYlcI62f@vger.kernel.org
X-Gm-Message-State: AOJu0YybtzQT0LFs6stxSfdkRx0Jf4XRSE7wKw8jYlX/24aLrq5qr/dz
	83I/vI+dgU6pgpGpRyNY6nw0ezpk1ZrJkhW/h2/AVRXVLQGrC6GX
X-Gm-Gg: ASbGncvdPIgXHOhZw6h7oo7wjjej4zTHUB8FGepVsW3j4pFz4QjH5ZcijHo+aWbD1OF
	RdYz88OMrhJJSFL21811xUhr/R11dCxXGkZSQWf8cTmIbjwI0Z+DlXtaU2zB0gFYzFEIojRovhF
	ehf7XXW5kMDRAPCmcLgcJc2vFAe1fCFu+2xXgAeQH7V6P0OQcn7V38TxRG/3QwBQkM8lScGrQxI
	dzJKdBZcQfTlvKw1qSknw9/7cum7jwh4M6oFEtbHM7xbjJnUhwTfcsjr0sF4HtcNT6yoFCKb/3y
	mJKL15F7AKaRolGjFCSRO6aAkGKiARARR5O9Wm587qP6j10aDAQLYyWyPcMDaPwC0xIAAKoUY+0
	9LJgB7BDaGIiOfq6g4jji2VUzp/GcLwQrn8w=
X-Google-Smtp-Source: AGHT+IE5IVnIJxyXFVx7tpOdH4W/lDT2DeGNQVPUENuNEB8Z8MUByUOnN42OjvFY47jOgEGrNs7ABQ==
X-Received: by 2002:ad4:5ba3:0:b0:6d8:ab7e:e554 with SMTP id 6a1803df08f44-6e8a0d84b59mr204179346d6.34.1741017122206;
        Mon, 03 Mar 2025 07:52:02 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634904sm54272776d6.19.2025.03.03.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:52:01 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 260301200043;
	Mon,  3 Mar 2025 10:52:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 10:52:01 -0500
X-ME-Sender: <xms:IdDFZ91qPdm6aUPbaxLwNgZSU-ecpcVbjZe5Y9fPnhmilBaLZJNCkA>
    <xme:IdDFZ0Eq2x5WFRGS4a-JXZgIY-kN7FSog3L9TnfDELFmRLSDrnPQGmxxVWPPnrWyd
    Prq1KjZ7ndJBP0obg>
X-ME-Received: <xmr:IdDFZ967k1T-oUXYOzmJJUYUUO_UI9a60coFYRoCvcKGD2CLKN0C_PoXcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphht
    thhopehjmhhorhhrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshh
    grlhhlhihnrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    thdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:IdDFZ63dO7ezgty6HQDJa9plS1afYfPJqAC8rzU-P9T70qml9d63Tw>
    <xmx:IdDFZwGVZmtQ1LCo0D04cx5sDypS-4wErcFaxNUWZjNSfio0qIh26Q>
    <xmx:IdDFZ7_zXqAwGFKfcYe3YkgmGYBKZL37SPWdYdV8ebcJB-1HGUfypQ>
    <xmx:IdDFZ9nzHGAPyG7V4_0CQZouCB0Knr2SxAG23YjimbcVJGQaWKqGyw>
    <xmx:IdDFZ0GWJfKBSGzLUHD9HhyXdA2jfYtIPBymBjvI8UcKyIgAxkpx_3LR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 10:52:00 -0500 (EST)
Date: Mon, 3 Mar 2025 07:51:59 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cred: rust: mark Credential methods inline
Message-ID: <Z8XQH0RN858VRWtm@tardis>
References: <20250303-inline-cred-v1-1-b2527beace76@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-inline-cred-v1-1-b2527beace76@google.com>

Hi Alice,

On Mon, Mar 03, 2025 at 03:28:50PM +0000, Alice Ryhl wrote:
> I'm seeing Binder generating calls to methods on Credential such as

I would suggest using impersonal facts to explain why the changes are
needed. For example, you can show a compile result (with the version of
rust provided), which has the function callsites, in this way, it'll be
easy for people to verify this on their own. Thanks!

With this changed, feel free to add

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> get_secid, inc_ref, and dec_ref without inlining. Since these methods
> are really simple wrappers around C functions, mark the methods to
> inline to avoid generating these useless small functions.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/cred.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 81d67789b16f..2599f01e8b28 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -47,6 +47,7 @@ impl Credential {
>      ///
>      /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
>      /// returned [`Credential`] reference.
> +    #[inline]
>      pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
>          // SAFETY: The safety requirements guarantee the validity of the dereference, while the
>          // `Credential` type being transparent makes the cast ok.
> @@ -54,6 +55,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
>      }
>  
>      /// Get the id for this security context.
> +    #[inline]
>      pub fn get_secid(&self) -> u32 {
>          let mut secid = 0;
>          // SAFETY: The invariants of this type ensures that the pointer is valid.
> @@ -62,6 +64,7 @@ pub fn get_secid(&self) -> u32 {
>      }
>  
>      /// Returns the effective UID of the given credential.
> +    #[inline]
>      pub fn euid(&self) -> Kuid {
>          // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
>          // field of a credential is never changed after initialization, so there is no potential
> @@ -72,11 +75,13 @@ pub fn euid(&self) -> Kuid {
>  
>  // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
>  unsafe impl AlwaysRefCounted for Credential {
> +    #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::get_cred(self.0.get()) };
>      }
>  
> +    #[inline]
>      unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
>          // SAFETY: The safety requirements guarantee that the refcount is nonzero. The cast is okay
>          // because `Credential` has the same representation as `struct cred`.
> 
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250303-inline-cred-1d1050785e5c
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
