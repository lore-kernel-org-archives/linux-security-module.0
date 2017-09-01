From: alban.crequy@gmail.com (Alban Crequy)
Date: Fri, 1 Sep 2017 12:25:24 +0200
Subject: [PATCH net-next v7 08/10] bpf: Add a Landlock sandbox example
In-Reply-To: <20170821000933.13024-9-mic@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-9-mic@digikod.net>
Message-ID: <CAMXgnP64XxJGLyWqqNQ7P-Ok+UDydb+t8Pm9dUyXZ_9cx+Cfmw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

On 21 August 2017 at 02:09, Micka?l Sala?n <mic@digikod.net> wrote:
> Add a basic sandbox tool to create a process isolated from some part of
> the system. This sandbox create a read-only environment. It is only
> allowed to write to a character device such as a TTY:
...
> +       /*
> +        * This check allows the action on the file if it is a directory or a
> +        * pipe. Otherwise, a message is printed to the eBPF log.
> +        */
> +       if (S_ISCHR(ret) || S_ISFIFO(ret))
> +               return 0;


The comment says "directory", but the code checks for "character device".

Thanks!
Alban
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
