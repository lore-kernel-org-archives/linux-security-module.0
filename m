Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A405C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 11:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1456B6103B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhIMLSY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:18:24 -0400
Received: from smtp-8fab.mail.infomaniak.ch ([83.166.143.171]:48477 "EHLO
        smtp-8fab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238463AbhIMLSY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 07:18:24 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4H7P832GLXzMppGC;
        Mon, 13 Sep 2021 13:17:07 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4H7P821s1xzlhKSC;
        Mon, 13 Sep 2021 13:17:06 +0200 (CEST)
Subject: Re: [PATCH] landlock: Drop "const" argument qualifier to avoid GCC
 4.9 warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210910223613.3225685-1-keescook@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b269cdc1-a4f0-d614-f026-dc0f7c455da0@digikod.net>
Date:   Mon, 13 Sep 2021 13:19:19 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210910223613.3225685-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 11/09/2021 00:36, Kees Cook wrote:
> When building under GCC 4.9, the compiler warns about const mismatches:
> 
> security/landlock/ruleset.c: In function 'insert_rule':
> security/landlock/ruleset.c:196:34: error: passing argument 2 of 'create_rule' from incompatible pointer type [-Werror]
>    new_rule = create_rule(object, &this->layers, this->num_layers,
>                                   ^
> security/landlock/ruleset.c:69:30: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[]'
>  static struct landlock_rule *create_rule(
>                               ^
> security/landlock/ruleset.c: In function 'landlock_insert_rule':
> security/landlock/ruleset.c:240:38: error: passing argument 3 of 'insert_rule' from incompatible pointer type [-Werror]
>   return insert_rule(ruleset, object, &layers, ARRAY_SIZE(layers));
>                                       ^
> security/landlock/ruleset.c:144:12: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[1]'
>  static int insert_rule(struct landlock_ruleset *const ruleset,

I guess this is a bug in GCC 4.9 (i.e. missing automatic const upgrade).
Couldn't we backport a fix to GCC 4.9 instead?

>             ^
> 
> Drop "const" from the function definition.
> 
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/landlock/ruleset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ec72b9262bf3..64c37af88ee7 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -68,7 +68,7 @@ static void build_check_rule(void)
>  
>  static struct landlock_rule *create_rule(
>  		struct landlock_object *const object,
> -		const struct landlock_layer (*const layers)[],
> +		struct landlock_layer (*layers)[],

The "const layers" is not an issue, it should not be removed.

>  		const u32 num_layers,
>  		const struct landlock_layer *const new_layer)
>  {
> @@ -143,7 +143,7 @@ static void build_check_ruleset(void)
>   */
>  static int insert_rule(struct landlock_ruleset *const ruleset,
>  		struct landlock_object *const object,
> -		const struct landlock_layer (*const layers)[],
> +		struct landlock_layer (*layers)[],

Same here for the second const.

>  		size_t num_layers)
>  {
>  	struct rb_node **walker_node;
> 
