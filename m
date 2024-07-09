Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBC7E765
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567167; cv=none; b=QlvDla2wsKq+UZaFPuFOa1H2tfax8UQMwR/dliwxJk4kMzsLa/rcysAWk/5cdx2qNQTuAMu/DAfgjWWOCBn1kQpk2gK1r1sT2bzfAxkwRG410La66qWPsvWIzFgq0eS0RX9SsWQ89QqUpjQDDxXQRMmZgjl7ZTZ0rYcRpc4mqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567167; c=relaxed/simple;
	bh=Sr09OEDgk+IDF34gl5syNKqJEt6iFC5F+z4QjFIlqhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBqMV4nyyjpsGjTqGVfbzYH2eAfFoNqz/tWheFO4RoFo+y2nbiw20eFAQqKBfI78fD9FJ9W1lGhUQFPWw8iQ1DQLBri0FizccTufBBQBiJcsEocS+taRLYyStXvrnAFFJ4sV6C998UVdfCht5IMItJKcXCTbpmY5VZ/4jhyW65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KwzqK9LH; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KwzqK9LH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720567165; bh=r6q9KsdOKo12CPtvfd+g3N1lYg4KeeqsmaXmiij71JM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KwzqK9LHglDlaFM9pplNoEstyXbJAXL6dv+kgO8nrGO+Ogagdu210B1oRnnzGiFEMnVZd6TtFkP5R9d5N3LldwRx/bLpkIKjiYgdXA2p1v2hZUnZf4NfR922dP4panKKxkQNPuYdcY83Y+ND8bYAcaQPfzkTHwouvzZH1dyEebHpmOIhBKVfMkpt3fNKoD4OLaIy5TsdP30wqZN2jk2fXMKu5uusvvnMKFzPLwi9p/mwtLzgAOz8ad2e7oi9aMD+2VndVtKlTx+FbSQk2QKyoWi4vjgJMxghxlGDd0makUvjiDyk1xFOTMThLh9cLI2NzB+KLxO2QKLE/13R8F+uVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720567165; bh=VbeCfbps5T9jjWEtERs/uUxgZJhZdFU9NvJmsBI37/t=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a7W5WClvpEcrKXuNhYdaq/nQ+J2l1ZVquh04IM9o4l4km+ZnMSFfAJhPKpNFczLAzNMEiNTbXFINSA0vsXC5r/RACt6OJ18vtb1QUckxuMdnWxnQjy+hBnszyiypJYDvNmKpOiW0G2a8UufY7hT4niTIuqJo6rAbNr9UbquuQb7BdK2k0FpCZiiIuB1kNJKkVuzmAfiSRBwVQ9zvxH9nc+eG1Jcy2Ql6zHdzju+mSpHg8b9zsjD5XGvt4iTHn+BTyk5rplrvpP4tzQaWPhKa2MJE3S5uzhBcS9V5Np0Vh1I6YLbv7pyqCzUb1FPQK2RONgStrFqEnFoPyQAKII/EKw==
X-YMail-OSG: i4HMDS4VM1mGWTyvnoJLCLmHWU0Szp3VEhbOqooUYDAaekgyDTi3Sq9Sx.LmDrv
 63b.zM6ZoJB7Flep4mmBtRIVJlmwQkcThj_5cULUWewssiSYXXZQQ_0M3XgQT3ps_jgg2VqqMi.C
 Vxekid4LDd4AA0zisr8Vg9Wtx3lGTQ8zJ1ZEclawIcIg_ItXjuak3UF0xK6oaLBbeqUlqwlqXUXn
 sMs_vMIT3H8VZzdYyJKg2mK2Hx7F59xrgusIgg9PEc5o_c3bQclCkTUIqri1XgqX2yGH8TJyhHr1
 lDbWPGiL4FRemL7ybJ97SUjjmfu75kPw0ql6VRyS0ORpFxTIKtvZUHeB0_rK9TDkuszhLqesQDu7
 CS8K68hQO_yDyr52LqZ3SHaFjsYiBbyLH3qCse_ikZ1Xwlhp0Pyl.W2.Dg.dTjrE4UfeFGmE7Agw
 wQInNuK_GX7mUFDretSZPI8l4hRdugI9g8y3.dUPe4UIOjOx74aEV3WBQrqN1uGo6.txqnI0lmCF
 jA07YoGcA2EYabuEabW9ci1EFA34ZPCQNgjC9NCm2UxIHN_X5qxKBZb.wWIHJpbCnqcQHhOJS4gy
 IkTwTnNoXA0VGYX0fHGbY6k1PBCcRUSchAjAjoP4ASecx4N4SbKD1TRyIV1SCDwxRu5LleKIAdFN
 1bRwh6RnH0Qzl4qhrVQk7RpKGXUQilEU1_PsaeZfbXp9.YpinbCzB1qaSqVITNkVPwF6LEbDo.Iu
 _eGnDluevfrBuMYoQxK2U.rHD.gVJlodj.tCt0IR4cDcIE9PBQrJoNMuKyIwdl6KIXpHHp3HDndm
 x5vmRIzH_k6t_AE3F8RyA1bVGlHOYk.2wg1F1lUloWb4Yox4wIphIIStId6jaQtCP6FaMZtXHX_I
 oS3H4bxWwbkUKzVt2uHH9onwXtshGA5KwzSmfdT4HVatP3KrUsrR8jFwlmqb2oA4aKWxgep94IEo
 fKIhkp_Zr.lult6jPbLLvMRVRa20Q3LJO2FQ_c7rQQKt90WHnHhlAGGElSa0GLME2IqiO3rnDMjN
 b4NPBmBz2U9IiE11Hc67514woEYDBUeh6yA2KyvTiIdZMly0WuCdk6Bz6RWuO5zs5CAAH1r2SUK3
 C7OIPWnFS61HeqbbB2MOPee3JunXTPiEfii09tVd.QRFnCQL1o2ofZkE__6_nmO6egg5doZbkcyL
 RR3vAHLCfthGKrz3s40YAtNnuejxpTDEST1Nq7hEsW2aE53CJq0Pe7WvqzP6dw1XrhDsWvjI52UG
 5bUwkMIcJS.rk1I0e7LkL_D7Tt.j18dpdjP5x8PTSEXnLq302FaJ5GV7AN9Ms12y8v4I761Ql_1H
 QvZVS8JPMjQSpLBFSztJ6ohiq558Qfv7tdXs3r6TChaLoi4SNOvlEpb309FCgRXnGAjQWcK5l0zq
 rvLUx8D.VimuE6itNdln9Ls6VVMFdeLfp40z7q_I9fJggwTxS1fgnwDvF4uTUC9E06B5gwUlnDHg
 huKq3Gu7h5OjArRR6zwirU0Gv_frJTnoaNa4i7Exq4cwsfIexLZnUbV.3p7W0t66Hv9jsTgg4F5y
 u4lCFqRXqJRh98X3V_1pIaU8sSF7gOduCT6tTcOE5J6ybC6_3YB2nEBa8iETX_b4y6ucTh3k.SCp
 ibGgyf37fWYfkB4cGRnv_XKqpw9YeBWYMaGTllLG1lOAy2sxMtLUF3y_m9os0upJyRsi1kGOKrrA
 5oXPzPW2O85EU0UDq06IvlO1JSLTQXgNSHatCkkfWFlVuVT84YvzdjRgSw2JqbHpg54lyVoydgO.
 b6clxhQ9EhxCLJ3kIDhuo3rE6wbxVKdKfNlV41I0V9q3xkHHKd2BqrXNAdS8PZWL9QFPmeoTEMOD
 soJ7UNjeEXwLIjgoJPv9iGUITbR4SMZeIfQ3d9sxKgx2.kPFIEzaUVaUF6gKVx6JNLfNi185159B
 LEQfM7eSx_fyn6Yg8Z7onZnz5oghWrneG2rQ78dKdDh0Vjm784XXfc4SwMMvY_IjyrL4GjAtU3hw
 tmfIfGinVDR9iA6REI0y9a0h8zB6WaXzH272LtIq_2DsOHxLM_0.QQxLY4dTSMxdXqGoSJ81BhUA
 TX6qYk9bdmATBOeC4eyACJUlj4p0jNQ.N5b.Rgf7sLZmYor8Rwa0az2ZCNHoIyUIb2LfpCwVGRSv
 wZx7aMvhI0m9xOglm3D9O4.szFOb4odOVyUJ9lpfZvBQ3uGqogDo.PTqoKcmHv9riNtidk0gc770
 v.A4OCFKKmb8.f7yEV04tRC0SqIQmk1sT2eYxKRXsqozn4JoPAnHFArZoavi8sdgnlAEAlPib0YO
 yn0J4SiPm6pUY3lA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 23956769-4401-43c6-b3fd-7a0d999dbf46
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Jul 2024 23:19:25 +0000
Received: by hermes--production-gq1-5b4c49485c-gngrd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f40b5c5275113fb61bad9475a7401a1f;
          Tue, 09 Jul 2024 23:09:15 +0000 (UTC)
Message-ID: <df7a8220-b103-4938-89b7-ef2d028310f1@schaufler-ca.com>
Date: Tue, 9 Jul 2024 16:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] LSM: Add helper for blob allocations
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240708213957.20519-4-casey@schaufler-ca.com>
 <a7b378b26bb6b6cafb05d9102da61558@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a7b378b26bb6b6cafb05d9102da61558@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2024 3:08 PM, Paul Moore wrote:
> On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a helper function lsm_blob_alloc() for general use in the hook
>> specific functions that allocate LSM blobs. Change the hook specific
>> functions to use this helper. This reduces the code size by a small
>> amount and will make adding new instances of infrastructure managed
>> security blobs easier.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/security.c | 97 +++++++++++++++------------------------------
>>  1 file changed, 33 insertions(+), 64 deletions(-)
> Looks good to me, but as it is dependent on 2/6 I'm unable to apply
> it anywhere right now.

I can reorder 2/6 and 3/6 if that would help.

>
> --
> paul-moore.com
