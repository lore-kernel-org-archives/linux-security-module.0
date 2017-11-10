From: tixxdz@gmail.com (Djalal Harouni)
Date: Fri, 10 Nov 2017 11:45:17 +0100
Subject: [PATCH RFC v3 2/7] proc: move /proc/{self|thread-self} dentries
	to proc_fs_info
In-Reply-To: <CACVxJT8NPnoH+FiXUyyb5Ehjo=8MYhJvwWWWKi5WE7gmhtf_4A@mail.gmail.com>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-3-git-send-email-tixxdz@gmail.com>
	<CACVxJT8NPnoH+FiXUyyb5Ehjo=8MYhJvwWWWKi5WE7gmhtf_4A@mail.gmail.com>
Message-ID: <CAEiveUdnrZijJgTNWaOtH5pLpJ1WaEQib0H-o8AVsU0Yy89_qg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Nov 10, 2017 at 11:31 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On 11/9/17, Djalal Harouni <tixxdz@gmail.com> wrote:
>
>>  struct proc_fs_info {
>>       struct pid_namespace *pid_ns;
>> +     struct dentry *proc_self; /* For /proc/self/ */
>> +     struct dentry *proc_thread_self; /* For /proc/thread-self/ */
>
> These are redundant comments.

I can remove them, but actually the area is so difficult and
uncommented that I won't mind extra comments...

Thanks!

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
