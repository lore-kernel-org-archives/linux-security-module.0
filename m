Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFD1EDA0B
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028511; cv=none; b=AqDzmqTijLYsmJihuN7y8cmJxIv3MoZ2ye4fbzOzWkqBtrq3haUcCdN3awSkecmPUuk59pOKe/WGuuTzy1PMFG/LiAYF0OhBsYkiOBTERxE7clOAAVEZ75fc1DByiXnXrYmki01laz2/TqihnpRJIflJqp1hyTThoFUaVIH4Lnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028511; c=relaxed/simple;
	bh=zttb/KBNS8YrkZTTRzEXOV2zM8d85NRFoEcHxhNsqPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnBykmn/jwgwCimADurl2fvV+zAb442AI3SzxQCnk/Sybj+DTJ7stPmakZuqSrrb4df4yfDsAGYMDh/tTsbQWB0cM6bJKd+8FxI0dfsfYpn1niGDJIjvuKQEPZS+GFb/NcIHwsC+bsYRGH3BQtXmTGzjbTrXc7yua72JOHgCZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ugCewM1u; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ugCewM1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741028508; bh=kxho3F4dy7xLzbeT4DOIL9QCojHaIl0A5BraM7FirZA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ugCewM1uHUhgr6fRQSvepdSvwLwnH6g9SpQ73RIoFJoYBrBybDjJmAtXUhyF0caP20iMbj6f96kBs+5nDgAhTVh956GshDa8NBH8HgJvF20GizJwkJ2SiZLY0+qRYS07hF42Ip2yr1/87RtC15xVD2kAlUrLVZoHVRt/sMnXCFKmPK9GWn8WRb+wcYZGV2O6jmMVwCfv166lhRtT2dNq/ulKqzxUzs4r2UqIg2Bm6Fn9K81jxA6Z930OBIDn26obg/83YE0WnUu1UINubQbHk8BwPyj3uViJOyzdkLdWrrjF3OqT+tGFiHqUqKf7tGKIK7ulCis12gELBctrOgDBUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741028508; bh=uwV/E0+2jUpEwq3wS75xbFMfJacGUlizbhG2uCwzYFR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VyjM2Cn7jBNZh9DhFTpLJKmIgSnqQhvON39GAI9DsV2hZjC8f0kc4s6xeArT14pfHoWC8M6Vw05Ztz6WJ0v9saWFxKOO9u+skeMKP8NptlhTzFiJ4mfMuKJ2P3DYtIoGt8Y5WqJkrafGKezzKlHzJ6vlJqbczVVv/a0B5E+2dCQi9j8LwrRqkBlyC92Ri6iqdCFv9ZzPikBbDoD1QkBkTOy3j5f2/AZ3VmSBs8j1loed9m2usVjZejTXc0bwwUkwVQPRYUFZ/qfkiVNa/QTcP7NQYUZ0iFkYksrMicdLPz10+SwHmKU/B/5s8KnoZ8Ci3VHcvOJdOBbWuWN50DiSXA==
X-YMail-OSG: jxQi5PYVM1kjCffxcWEXtBaaD8eOjDPHNKGLO2go4aEn_ycpi6E.Y0dfQ.S.YMc
 q6pdyCDwv0K_8wef_nByeNMVwM5pD_sN3CSMc3qRrIULnZitvm3vaUadnWPu6bVr2ylsXEcsKr.c
 kPwT3x7Lr0N438.MiiQAVH160Hi6J7tb5M_YlYrkx9vamBwaK8Sjp3DidLkga2U77V8.fQNW8u4n
 zbY27gYWrvMpq_O6W8ocJ0dr2b0gWLt_TsHNw4h0JkQYUfFd8FBjiiJWem.qOE5123NBUA9LlRNr
 csIZtRl8lCPdpX6cTowG.LwX.ZsZyKMA0b5u4LKSTho.uefunP0yzd4K..wF3.ZRhOm8VrT4U4Ea
 rM8ZcO.nk9alqipQt4QQlBRIlLYRzE_CnKjspf7i60FvsLZpcMZUdiJLv5DNtxWlf4SugOGznBbb
 CuSRSjAPkQ.7.g6gaqidjtq6.WnpCyz8H7SmqClPiTJ9laTpvyHdWCmTJfIvXg4LTt658CiIaW3k
 7glKvyyKDLLP7nNVrndcnI1MfYkiNW_5jV4DcKKTmYVVx661SvWgueDHSLGkYhAFFB0QCstQvTzh
 SdBsG07Obuf2EETA_.KgwDpSdnOvZgnkGciCDrEXNA8f1iekrdWB1xlyzAylytOz8hNFj1gmaWbn
 T7oWPOzEPd__cl8HikekBiYKjiO6A6DWu2nxeaUPg2dbKZeiPa59NLIBE04TTfC7iTV_2pnPOmqy
 bjJ6AFabBCtFWkfWvD1YFKJduagIUR_m55F_rF1BmoHMx3NWMyhQcBRUgxeWATtH4TZ0CqS9tY3j
 i8wIv_zqg.sjUm9bKTc3BF5oTDjoLo3AROmd13sGdO0v8xEG1tAgewkbC5maE2MW5AE11.3cNkVN
 lSxua5yWsKERUhH87Mgp_65Mt1pFQQtptHz2s9GTHCai_3mX.iTKgS7Ri6Xm9Sw0rr8dLdfXw9VZ
 TJh5HgYw_FRQotOHF9q.FNnPyNTOOoSw2y2GTVhyeS2nQP4DXbaRmRjG2oZeEJnqrrMlgu2jGZmv
 zBjKuqA47HegMRKfM0BnsB.ug00ATF.wA2iYfUbNAkJJJYJObO8jEJ8Nwl0H3.ck4Og5ZjjDXrnP
 m4__Zvgy1GVu2_iTrIVsxVehMFFF2jNbzdfy5upaXuQV3HYkthvz2JcbEBkTKKDI9WOhIUARif1h
 1BxAD31zL.kClhGIqVB9rYhmUYevTU92KHrtHkqPmcqgeaeYtfm2wAlabWF46ICzUHcdO2eVsCyo
 K5LVgDsjA5fUvRVTVSNOoAR.dPlVwMXUo5jbEG6K6SXxLgLZvIiGvbnbLdbfIsdTcLYXRZd41rB8
 tnz.dECl31x7CvA1PO_ZW62rsw88kEaC7K3bFxqwKJi_VWuqF.4QCFuSoUBzhNx5E.neXMW6oBvZ
 Ylsu8g4Uw87PavLmxhmYFeJbegExm0rVHOpbQSHHcw1yVGYqLyp93VibYkErHzBOqiFHGpZU6twZ
 PryMK46tQp2HCY7vAX72tV_d_AcddTOzsSjV4WxoBm9FtQAfGVyTBmmhTi4Y.rNbIPg3KuEdqLOG
 uhWdpcp7323PikTR5IKx.d.BslA6A0Vxh_PkKZy6q7F0GVynqCDq6cmmAMyQ2LsPUe5a1NvIn7.B
 jEsKm5qJa14eLQ1ZlDUXr0CJo9Y_X.HHB_fgt4kvH6.QMsRRRdzNledkkQ1E0jTgJbxKX0jQtZNo
 _BrVm3KehfqDt2kxqAJ5p1uPN6ALJ_Kor9ayh8Sk9ngCXSMUPuRv5f0FSU9Y3mGvP95BIJFR84HC
 HffW9KLRatVWPmwOwO.zcap9rgUzxd8ppdKFe18wRloPjtTUTW4.YFwlJ7tqNKDPG6TTNmNtOOEo
 fiBGJKPKKTtBAa4QzZ91EcL7U1gUBm5J.KrUb1O6icWvzCujCsctwDg8FXKBOQ7lx9vGZoxpbd0I
 MW8cqKjWo6Nd7I_y9tlg.g9pe1P.Ujv_r6JhDRMtBFy46zb96VopS4q14Wy6o8zY6fxS3N3rmu.B
 0yWtVHs9TinPKjn9Vma9ix_VI9dElJD0JQMruCNVINtixeyLr2t0ANBpmEILpJPpD0.b9PQVfeut
 9XFxqrbU.l7ehL61q8Asjxqv0h9rfnxWejzRPJtWPt7Sd.zkMtSE9s8pGDfjOpME00twdSMp47F5
 UL008WKHvbBK3uvE81JUQLvdVBX9WQMf6wbdNsle3uwqg9sqU9KzdT8LKAXAegMg_e3GzyyVHiZU
 x6NEyjNYjZAYdnxanLrWhgvd1izkLscoMQv8pwd3SDX2BJf3uD6xvhHLMKwnsJRQ53zoABXrV3xj
 tr1hkGOnaygVe7gvnlq.5gw2j6Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 96345618-f8ec-442e-82bc-261f2ecd13a2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Mar 2025 19:01:48 +0000
Received: by hermes--production-gq1-75cc957d6c-bs9kb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a55dafe6a07e9ebe5219b5cb6e8d4ed1;
          Mon, 03 Mar 2025 18:51:38 +0000 (UTC)
Message-ID: <cf588a4e-cfc2-45b1-8ed2-1a7587a2a0f0@schaufler-ca.com>
Date: Mon, 3 Mar 2025 10:51:38 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <a5262d73-2b11-4868-9c6b-1c6161808979@schaufler-ca.com>
 <CAH5fLggNnOv2rhtUeK38GVQ7EuuZkZMwOSVKSsMLFG5eS2i9Ng@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAH5fLggNnOv2rhtUeK38GVQ7EuuZkZMwOSVKSsMLFG5eS2i9Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/3/2025 10:40 AM, Alice Ryhl wrote:
> On Mon, Mar 3, 2025 at 6:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/3/2025 7:29 AM, Alice Ryhl wrote:
>>> I'm seeing Binder generating calls to methods on SecurityCtx such as
>>> from_secid and drop without inlining. Since these methods are really
>>> simple wrappers around C functions, mark the methods to inline to avoid
>>> generating these useless small functions.
>>>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>>  rust/kernel/security.rs | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
>>> index 25d2b1ac3833..243211050526 100644
>>> --- a/rust/kernel/security.rs
>>> +++ b/rust/kernel/security.rs
>>> @@ -23,6 +23,7 @@ pub struct SecurityCtx {
>>>
>>>  impl SecurityCtx {
>>>      /// Get the security context given its id.
>>> +    #[inline]
>>>      pub fn from_secid(secid: u32) -> Result<Self> {
>>>          // SAFETY: `struct lsm_context` can be initialized to all zeros.
>>>          let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
>>> @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
>>>      }
>>>
>>>      /// Returns whether the security context is empty.
>>> +    #[inline]
>>>      pub fn is_empty(&self) -> bool {
>>>          self.ctx.len == 0
>>>      }
>>>
>>>      /// Returns the length of this security context.
>>> +    #[inline]
>>>      pub fn len(&self) -> usize {
>>>          self.ctx.len as usize
>>>      }
>>>
>>>      /// Returns the bytes for this security context.
>>> +    #[inline]
>>>      pub fn as_bytes(&self) -> &[u8] {
>>>          let ptr = self.ctx.context;
>>>          if ptr.is_null() {
>>> @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
>>>  }
>>>
>>>  impl Drop for SecurityCtx {
>>> +    #[inline]
>>>      fn drop(&mut self) {
>>>          // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
>>>          // call to `security_secid_to_secctx` and has not yet been destroyed by
>> I don't speak rust (well, yet?) so I can't talk about that, but this comment
>> has me concerned. Security contexts (secctx) are not destroyed, they are released.
>> While SELinux allocates and frees them, Smack maintains a list of contexts that
>> is never freed. A call to security_release_secctx() on SELinux "destroys" the
>> secctx, but for Smack does not.
> It's just a comment on a call to security_release_secctx, I can reword
> from "destroy" to "release".

That would do nicely. Thank you.

>
> Here's the full context:
>
> // SAFETY: By the invariant of `Self`, this frees a context that came from a
> // successful call to `security_secid_to_secctx` and has not yet been destroyed
> // by `security_release_secctx`.
> unsafe { bindings::security_release_secctx(&mut self.ctx) };
>
> Alice
>
