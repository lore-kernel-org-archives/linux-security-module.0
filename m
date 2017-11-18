From: paul@paul-moore.com (Paul Moore)
Date: Sat, 18 Nov 2017 08:27:48 -0500
Subject: [PATCH] net/netlabel: Add list_next_rcu() in rcu_dereference().
In-Reply-To: <20171118.103536.965800271330929492.davem@davemloft.net>
References: <20171116170334.GA141280@debian>
	<20171118.103536.965800271330929492.davem@davemloft.net>
Message-ID: <CAHC9VhQfH+PNTxZynhSstTF-pQk7xwtLaZ6hXQEkDZfmpLU+aw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Nov 17, 2017 at 8:35 PM, David Miller <davem@davemloft.net> wrote:
> From: Tim Hansen <devtimhansen@gmail.com>
> Date: Thu, 16 Nov 2017 12:03:34 -0500
>
>> Add list_next_rcu() for fetching next list in rcu_deference safely.
>>
>> Found with sparse in linux-next tree on tag next-20171116.
>>
>> Signed-off-by: Tim Hansen <devtimhansen@gmail.com>
>
> Applied.

Thanks guys.

My apologies I wasn't able to ACK the patch sooner, I was traveling
and had spotty network access.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
