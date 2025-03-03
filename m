Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C07214A60
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022243; cv=none; b=GVxwVSWkjiKK4DkqmwuwGs03zeU8HfHrGTvk6lyBXnDxLX84Z1kwEHujN01bPxwKj54bUQal5lCbHV4pvJHLNpNeSHJt7QrrP8d/qTrSIlumtNGl4ob1paD6tqZ072AKxJSq8BZacJbb89mLLvJf9UiYQXDhOQkLU0sAFtoLax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022243; c=relaxed/simple;
	bh=BXgA2nIW2AynOPt2N6uqtvm+0vS9wlyZmMeLPDYpVfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h738FCqpIzLY+jvlSCzGHlze7hwvdTVPxHF8LNR4UKo79dKe/hg0GL8qzTn0O8tC/9V6ULGRx7obXLHNwIwouCfxkg52Rh+mrhiutA2VZZ3WiSnI9Np3l7WpGuvMnjKygvzQ9H20DUb+qKV9Kayl71v3rwuc1AALggB0xKnabq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PVw+qTBL; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PVw+qTBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741022234; bh=hP1OnH4rkzfpXtxmBWAtBNXVCk+obvexO9dLD5paXaE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PVw+qTBLRv7h3DafcWrSU60VmGFt4PEuwHsJqZ/xktrKHnTm6UV4E6vIMpEFgBm3vQ1Dwx0Khr9+aWEK+84zZ31lUs1yZjvsxiC884aFQWiHNP3Hr2Jl2DHet2V7UZMXM6ODIDuqCLFUQC7Z9VHVrd9M5/tJg0NU04Yw5rvG2/0bD83H9Y3xB4eoSqWQ8s/3SWlfyJXx5C8hVWYJxiQWE9nZ+NuNhU8lof9GmNc601ocF4OweLdN3I3zO67c4eIdOprNUaTpH9RXpRianDJjQ6p+BMDLjP6bX1mX+yBKb8QkRLjkUrHfl2EBUNlrGWLsSOzPdOgadeximP3WK+aSiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741022234; bh=7PTzntObKlEmGgecgA4GzS0QCu29vxFORYnzqUyFJdX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uV4Rjpin0gHit5ropLfXc4RIm03WSnDpLH9vdeTOoBrrJMU62fmKcrBbrMRY/3TyIrn8TobCrLW38vFvbVCnO8ByHzI/GAZsauhqYxN1JElwLC8qRJ46QwaD8qnV80jQa9N2Tb6VCT5yNwsQLQLRxU3uRvWfVHEIeKwsdLLBX46O/Nha1kABEZwyryqab4dAuHVZbxgRUqtz6v1P+7j4VMaDtUr4QQXgETT4KsCp3Z4BwVStuJ+KQ5H1Hqx8dlc+QqA1ELLvx8eY0VPqghIXUOffZl9E3GowKHw3BRgHKQN+cOzEenqoUlfLyeIhwlMgZPo0Xx31XnFPvAIRs56ywQ==
X-YMail-OSG: HTl21DIVM1lQ9mcIoLyvb5fjJFVBsKVNSsInMEeqmU38I.wc9azToU82xx1QwPq
 7SXqKax1t1Me2yjCLwCE.LDCRg.mwE1EAIRo.2kr5AOQRIqAUmH1WhFfWBgXinHfzRnlt5haIKBs
 SC_i5_5gAuirVdyIr4dQzBwN4dsSVCSviSHf7xoxCqd6LiaN7Zc.6jVlubOiDb1ck.hw2hHq_vGS
 8P38u9bC2pUql.4nTFj0BnTKCyQEivVNFlD1OElMX58x1zIl2pI4hybVlHN4ZgAhnVqMKWqpOQRr
 xjCjetNO1rg1Fe2fUqSsz_zDnY_FuxsI.TkrzDX_BYIiid1J4db6qJy.R9Gd2_9hf_miBgDBJ0AL
 gLs98p3tj3AUrFXMRMdK4iqAAu7UB2ar.C6pegNrq.WCU9.79WhVhQ.TR7_LneXqiSBC3GH4itar
 9iny3SuOlNOE4XIfgYya0FEXTAmUL_edP4HDrKf449j6jweUTbY2uwEkjFCuw67I9PGH6olNBV6K
 k6l6gq4eD8wgvzvxoK5GgI49svxgcstsTtVLwGDnB1AjlSidn8neS_s7g_fHt9OrE8YGhS3xqwEG
 g5La45XZG2Dejo2zKyy7.yIz7r2Ni17w_1B.ImXIrU_Z6cw46L3XtQgUhDScebgmGPKBpq5QGkE7
 SShPBc.pTF8mKlMFyq9evvEOeQQAHCrQ0hJATTFTAak.LSisDZyORAjoxNIEJ2tBgZ90zG61w7mC
 SG7ufnfGuKuxMSZmNMSwp02QURH9BjNDbOoqiZhwEg5K.yGp7G38nKNZ2vsJbCrb6B6CpWvkctpt
 uSVd7lrGzEUDF9kMDuNMv.i2Zn1bAy.KQ1yQXUIK_Qc.Yp4xxVEibYznXV.Qv6q9jPf1Wpww_PrZ
 mPT7RG9PALHM2yj.ETp5uQnvpZb3MQol_G6cfG.OrtfIUTZP1.mVP5L1F2PZEJAahKW15gji7rOS
 o7PMPN5TjCB7ExGfYtLFjxfqb7L9OhETQMr1DgpzCJRn_BvSZ2bLtvGroSwwfc31C3IkfN2JuohB
 vNsHwMMuWkiQputTOyr.beTXyomSgqsumsXYVoL587bw.1iAUXfqTC4f.uCYevihIu2lYu4VzlWc
 Pnks7LR4Wimy53pMqUQcINi_4SI.B.dpPKlkk6aLE4yAsmpG1aceyzxuOKmDHKMjAm4pmbONSpAA
 KOmMT9BfSOXZx8pb4lkOMhEqKYoVPoPpWKsUBzjRuzv4Jf7X.5RhL5v9t0A6eJJ22mZKuRPI0XCM
 yUp.D8A02UtfLkr5bOV86XG6sDkmFmrGbZ7huSjgR.Lf5jFtLkmG0pzmeNZDrFzc.9x3wyxvLTj7
 jTXqMQum1kwT.IDbBLj1eSxEB3wMzUE.nxJ_h8zWKN8avO.Vrbvcw1bZYx_s12S_H72vbLa1f0A9
 YwCluZZi_vA68A0hwhcy298a2wvJBBw0qq91qTHY4lOwQjemFkd5UEYFozzOkc_iejU92mogYhoN
 kxfB7408wn9I21vTH7tFbQlEuNQJgGd6Sa9zPiMrnjxtnReBWGKM27JNPjpE86AIH7tcAh5HU.lc
 VVXmQLvRMlXwG.e65K5VBwOkSYKm.4A_QP7elyUHdEzNxZYDmxzsZXbW2cMjFXxe7vVFPBWFsIRp
 aiOfPdJWzik5sevikonD5MgmjX5xLQW8njNggjfB1e96FrzahIkfQxVn0xxP.85YInPdmRssyPtS
 VAxzEAnrP4oue3UN8q0vplUBHZ8CsudEzs27azW5KUI6CtDqpZ9LFnDkSThXXw5GDeqdiolcO6j4
 ZcqGQ.aX.3gzEefhzw_A5.tgFLyii_Et4u3LYHslCh03Nh4gJvudj3vUVzQg0kQUhRuydaIQQVgz
 .NLdNVavz0NHWkTOfnKfu3vczVu5.yvPn_OIRhD6fmLK_LvELmukn0WGuZXlEwLp6_.XLfJBCOL3
 yjUv_vHonqQn4302avIokAdKsUuvNqj112T.oKli.I8xBca15s0LVqBDVOQqlJx3FpbDMgb8.bKo
 ySqF34pzOlxvjoqWxNMaEPxjJA5QZnQ4yk2WVEityUzZo8F3KpLlUh_NwCXBG1.V405gqCFoGypu
 Mh9eb7oB2c5F5fXeqz0W_GtdHryk.e70TzZHWepnEuqeng8L6CF02dov0Q5fYquG8.BgExmBO_sn
 D5zMALuw4aTMmoPom8I.2uIKOyFBVZejccuMq9wDoBdWQTtUsaYGnOM2u5ifWo0fdiKIuW8wznNd
 DqjBxKeycElUjzljNByWfKt779EZ9EEi.a9HGQzmmLojJ7Ud4KAWzRVvMihsDqT0pApDo62IobJt
 BdgzVioKPjHIsOdsASJH3NM2JrZjc
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d59a7578-59d3-459a-9f1f-6ffd7be991d4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Mar 2025 17:17:14 +0000
Received: by hermes--production-gq1-75cc957d6c-f8j6m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8dfcbb99da5a01dcf02892f88cbae8e;
          Mon, 03 Mar 2025 17:07:01 +0000 (UTC)
Message-ID: <a5262d73-2b11-4868-9c6b-1c6161808979@schaufler-ca.com>
Date: Mon, 3 Mar 2025 09:07:00 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/3/2025 7:29 AM, Alice Ryhl wrote:
> I'm seeing Binder generating calls to methods on SecurityCtx such as
> from_secid and drop without inlining. Since these methods are really
> simple wrappers around C functions, mark the methods to inline to avoid
> generating these useless small functions.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 25d2b1ac3833..243211050526 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -23,6 +23,7 @@ pub struct SecurityCtx {
>  
>  impl SecurityCtx {
>      /// Get the security context given its id.
> +    #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
>          // SAFETY: `struct lsm_context` can be initialized to all zeros.
>          let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
> @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
>      }
>  
>      /// Returns whether the security context is empty.
> +    #[inline]
>      pub fn is_empty(&self) -> bool {
>          self.ctx.len == 0
>      }
>  
>      /// Returns the length of this security context.
> +    #[inline]
>      pub fn len(&self) -> usize {
>          self.ctx.len as usize
>      }
>  
>      /// Returns the bytes for this security context.
> +    #[inline]
>      pub fn as_bytes(&self) -> &[u8] {
>          let ptr = self.ctx.context;
>          if ptr.is_null() {
> @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
>  }
>  
>  impl Drop for SecurityCtx {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
>          // call to `security_secid_to_secctx` and has not yet been destroyed by

I don't speak rust (well, yet?) so I can't talk about that, but this comment
has me concerned. Security contexts (secctx) are not destroyed, they are released.
While SELinux allocates and frees them, Smack maintains a list of contexts that
is never freed. A call to security_release_secctx() on SELinux "destroys" the
secctx, but for Smack does not.

>
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250303-inline-securityctx-6fc1ca669156
>
> Best regards,
