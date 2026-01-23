Received: from sonic314-28.consmr.mail.ne1.yahoo.com (sonic314-28.consmr.mail.ne1.yahoo.com [66.163.189.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BA2EE617
	for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135915; cv=none; b=r5ZRKtMWsqZSzHk+UlC/nMf7SyHE0Dj21UT1QKnWPs+eKLFsyjA6dV/ZvQZFO+fcf3M7YzrJc5eb7UVXqRxmy3qz2RPkpCHCc6XosXuEnRkYD6ALN4O/fUyhpKCue+U3bcf4VOMYUPL4WR+StI8iUUqb/Xav73yp3xgzSpz1QMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135915; c=relaxed/simple;
	bh=vqEXaVCi3RbcN0ysaBISMtJxr8iChdFz1yI6n7D3fU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pygNPi5MQRMFy0tvUCwmaYEO8yQmLVLWv5tJZxLTcdZP+u4uKNkhcu+XPn8ljM/SDpkqyvbEhSdKu83T3IcGARIroCSRVbeDGoPGJQ3hdPwHRNWg7fxHdSBpifI1OfU4mb+plUTthe5lArgSORXerxOHoB1O2v8VBeS6BQ9Mi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=apMg7zam; arc=none smtp.client-ip=66.163.189.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="apMg7zam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769135858; bh=vqEXaVCi3RbcN0ysaBISMtJxr8iChdFz1yI6n7D3fU8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=apMg7zamNn3X/D0sX2wK4ggWEISSWpeoN/vkQFt9WefFma04tE1m3Y6qrxXbSon55CQiSonaJEwDLle32IVAMXEbz6BBfWQSQIBym8FW/j6TT2b38oDiDAYV7TWRIkOHFfSzrKQF9DOb8+Yw1rMtaZwI9xFYErUms3itajX3otcifiog3+68AKsr5RB+ztC76sCUJkzO5GGmvPF1DYlrWMP3inGB6z7dGvQV1lMW3/PQ4xRvUjZhIMMbGyimQ+knfhnAYqlsGb4pIzkeNE6w4apHoupLEPxVTjDK/PNpOfBZteLCs1C6Z69hgV6QoHTCryot5GXIlb/tmXRXXx+csw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769135858; bh=JbC8n4TEIlFqOv079tgZNg0ETODzvc37OnV1I0GNfjA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BueWAKYp8awqny69Ws38cjnWjvMC2bzLJXgjaZlKIBK1u2fmXw94ETDFfPJJKl1lQr5uE5g5lxMg0Q4yDNSl5joZ0NPd4pMGNxDo8OdKI+u8kAw8OlYbQB1piFFTzgMfv6bbW3+uHVwq1FsCq5VrVBmWB9LdAVlz0Jhw3LceKjYPHFYZKTOPkHFFjlcXv4TCVCm5kC0rIhab5y6SYt3M46HbOdcIeAlGERX8zsOcadMEEPN+P0qSJxmbjq1Rho/aFjYn0IuqSlnBy+eEA5nI8wprHCjTD/6dqMduvfAzZOrV9BOB9ltwFXVAaNoKS4Bcs5tpGYwcCnYxq3ChUhPlgA==
X-YMail-OSG: 4pxd8c4VM1lTHo66rI3FqLspIrBDlZgKkVBAigZ9MY3GJWZNlooC.KIA6_sxNu.
 0nK_D_40PRrV9uK69zGdSTIjeXKQYM_b6xpeSQ7SMX5ZCVFOtOwFxujWOAB4QIoy.G10sPaSx9f8
 QwqzVChv4HOd2JIc5Um4dhC5DodgYJpSQ21aen.N7ekJppkJJIxdsEcI1FNvU30iIwL3rlKyeCR5
 JCHbTpFW5drebtTNZKf_ub6q.Q5ebOkExLuik3.RljZOiM_j_P1y8eIbvfzOTfHL7vVBtlyxhrG1
 6d4ZbojwOrvV06Xwuokp70uEgsALDANqSAJuotuW1Hhi6KU2iKlSH2vpXP_PW.2bt8c2guA.UYeo
 hSPGMuWzDbyCuf1jhEr5040gl8bL33r80UbSBT85fVzVgGgcVEQucHKHuiNPy2mBfhKFHDxshr4r
 krsDIMaGDyBaCXNKRoUlOyyiXg7f66ABaFS94Jm3BhYh_5MmZTYIQYuIM3a_GsEAUnevJvxtKmso
 ypfJWz4Z8XzkbnS4dHMuOGguPduUWr2K2fwD.mTd.S7RVYHsT5jInodGsoPPhSijXdPX7bHcCtML
 lubjedI2PeZOvpWZ5iyF7sf2wKmZLh9u2NUKFM69sWrEBLIqEQUQ78nOTIwp.5bf2TqtHbPBJhhE
 nPqCNrgG3WmR9eWPGgm3To5bF4VTyi0Al8.KHVg4eeUQtizSzpT6nG9XFLk8xWlIeB9vm1Fke2Ym
 xYnwISQFMi8qqZf94hkhVINKY.2bErH5lo431ZtAmMcBXQ.3hElDh8TW4ya_s_2YkqdZibA3zTWg
 gMICJdVtBSwNAvFiSxTA4LSRsv0eaeNT1MiBuhtjjbNPkNteenIH09QKsMYPYnFFsGWoKRfGXwHp
 VBgz6jFzh83djgiLGnheRBIelA1c.9lHZevo.wJ6I6gUQO9qWXcaLwmI2_AskF2EXNvw6lBRzU6u
 WFzCGIgWsyNDWgMlEhAQYCq4sOsyxijS..2eD4AVBWZz4PN6r1bGMVKbmRQfsx1yXjRmMSZCFY.C
 Q2VPItVQXYOY5TOfaGM1obA3bO6xvR5_zB60yidgw9NHHLIXshcWpjTsI2Qmx0F02qEi.2ngi5on
 FGQNF6aJdRwl61wvmUkGB6LsC3mYDHHfI5pTsZvVx8VjZlQg8C_MCqEMbJpYQrn1XoEpHmeHhwnc
 8EjvE45Bc4t1R01IuZ3mJbalTd.0ltMENBm7q_xuKdaHW4.kIop5H4PWjBTBZQx80fYRUd.uePa.
 X.nauHBi4LrjX41H_rjYDb5JOjNL4vOXshMHVMTdnxyfRM_O8t5meREhhURMFBaqvkRKOVjeq45v
 M.MlVT9oOBgfr_1MzdB7vNK4fBixlCuvNJKM2lwN0I2kyu.leWETEOPdS4xhMtn5rMyUPTp801od
 RvVVZcVsZHEix.a2OQN1DGbJ7sXFYEBuEqhI4MOlMDEi8WNGjCowt.H8v3Q9eY.h9nKAtNDDm6aH
 kCbAXuBBwG90aLd8yxgRkGBCnp65zD62rAdfp8rtj3hZZTDGYRjQwIyoZBnxXZohuGCiY0PqA4E8
 Y73oR1DxQc45wwMei4qFg1d5j6WgIIcqMfUglHh25Di0LB8kyiJVSd946lv1bvbvioBAnHRFMZUs
 FAvGSYyqQFq.SjwRsUPKa8qJ95lBnHK3vwZ4VI4GzcXYZId6Jx0Da6KyOg9ikvB8N0gWIFe6zxwz
 hAhYJv7tp0u4mALc79xSyz4E5akRlCNuofuuSXB2UfD_2ezstid5ug7GSJMSiRkhzDmHaRM86sur
 xtoYVA1MrT8rZClnA1UBhxYLqxSGPPkxkUsEfxoXt0Fp_am1ausnQ_.v_VO69WVz_D4p40OOx2ew
 wALJQIkrAC87gs6LSMKOBSSPbsYgWGHvlWhO__rqAuPG_2i4238hoAi3lOZKhEmx2T.APBTlScqc
 VN_6l.FXor7qiE1UeYClWBzAkmlrY9BLzUHKOlx.teJhuXnf33DcC5ByyTotawS6qamsJTWqFATW
 0HhC84DJfP4xpznmaXqFUyBsfMOQ6H9Y2hHiuCrJxNNqInBy51sxqspbiyLVSY3tQhs7iEQmmm3U
 Ig2ANeUX3apAGtH2D5hJt8kpju4Wzc3nGM8hxa7S3l6dUN_KLHMGyNMw74pe3XhBmi3.voNPhwHj
 1popd9NsF_Ca3gxnSJkFpjgk9jwu4UPtsSnriLNHKRvmgE7QyE3f8g.0i9IOLkUtaK_OA2pR1Gtv
 usjOvO1rDOrOgLcd3gvzUAzKYaDgrLpOxrZzpjBKfX2AWzRA0APvkHT7nS890k6i6K967a9iikk6
 FeRMZad1svtw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6bd16f5-4ce5-45f8-bc24-63b96081a564
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Jan 2026 02:37:37 +0000
Received: by hermes--production-gq1-86969b76cd-qmsdz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26a1c629605e02226d9b5d383e0f6a08;
          Fri, 23 Jan 2026 02:29:04 +0000 (UTC)
Message-ID: <633aa038-4356-4db3-b61f-191cf56c73b4@schaufler-ca.com>
Date: Thu, 22 Jan 2026 18:29:05 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 lsf-pc@lists.linux-foundation.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
 <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/22/2026 3:01 PM, Song Liu wrote:
> Hi Casey,
>
> Thanks for your comments!
>
> On Thu, Jan 22, 2026 at 9:16 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/21/2026 7:00 PM, Song Liu wrote:
>>> Hi Paul,
>>>
>>> On Wed, Jan 21, 2026 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Jan 21, 2026 at 4:18 PM Song Liu <song@kernel.org> wrote:
>>>>> Current LSM hooks do not have good coverage for VFS mount operations.
>>>>> Specifically, there are the following issues (and maybe more..):
>>>> I don't recall LSM folks normally being invited to LSFMMBPF so it
>>>> seems like this would be a poor forum to discuss LSM hooks.
>>> Agreed this might not be the best forum to discuss LSM hooks.
>>> However, I am not aware of a better forum for in person discussions.
>>>
>>> AFAICT, in-tree LSMs have straightforward logics around mount
>>> monitoring. As long as we get these logic translated properly, I
>>> don't expect much controversy with in-tree LSMs.
>> The existing mount hooks can't handle multiple LSMs that provide
>> mount options. Fixing this has proven non-trivial.
> Could you please share more information about this issue?

LSMs assume that any mount options passed to them are options
they provide. If an option isn't recognized, it's an error. If
two LSMs provide mount options the first will report an error for
a mount option recognized by the second. Since hook processing
uses a "bail on fail" model, the second LSM will never be called
to process its options and the mount operation will fail.

The option processing needs to change to allow option processing
in an LSM to differentiate between a failure in processing its
options from finding an unrecognized option. The infrastructure
needs to be changed to allow for multiple LSMs to look at the
options and only fail if none of them handle the options.

>
>> Changes to LSM
>> hooks have to be discussed on the LSM email list, regardless of how
>> little impact it seems they might have.
> I don't think we're gonna ship anything without thorough discussions in
> the mailing list.
>
> Thanks,
> Song
