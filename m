From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri, 7 Apr 2017 19:16:54 -0700
Subject: [PATCH 02/12] trace: Make trace_hwlat timestamp y2038 safe
In-Reply-To: <20170407213011.36e29f42@gandalf.local.home>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
	<1491613030-11599-3-git-send-email-deepa.kernel@gmail.com>
	<20170407213011.36e29f42@gandalf.local.home>
Message-ID: <CABeXuvoQJSg+eVH4LX5s87DtE4N3goKDnjZgJ9fLk8txgwN+QA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>> -     trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%ld.%09ld",
>> +     trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%lld.%09ld",
>>                        field->seqnum,
>>                        field->duration,
>>                        field->outer_duration,
>> -                      field->timestamp.tv_sec,
>> +                      (long long)field->timestamp.tv_sec,
>
> Refresh my memory. We need the cast because on 64 bit boxes
> timestamp.tv_sec is just a long?

This is only required until we change the definition of timespec64.
Right now it is defined as

#if __BITS_PER_LONG == 64
# define timespec64 timespec
#else
struct timespec64 {
    time64_t tv_sec;
    long tv_nsec;
};
#endif

And timespec.tv_sec is just long int on 64 bit machines.
This is why we need the cast now.

We will probably change this and only define __kernel_timespec instead
of timespec, leaving only one definition of timespec64.
At that time, we will not need this.

-Deepa
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
